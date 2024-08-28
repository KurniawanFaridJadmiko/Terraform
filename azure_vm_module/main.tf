resource "azurerm_linux_virtual_machine" "contoh" {
  name                = "${var.stack}-vm-${var.environment}-${var.region}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    for nic in var.nic_configs : nic.id
  ]
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_key_data
  }

  os_disk {
    name                 = "${var.stack}-disk-${var.environment}-${var.region}"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  custom_data = var.custom_data

  tags = var.tags
}

# Create Managed Disks
resource "azurerm_managed_disk" "data_disks" {
  count               = length(var.data_disks)
  name                = "${var.stack}-data-disk-${var.environment}-${var.region}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_type = var.data_disks[count.index].storage_account_type
  create_option       = "Empty"  # Use "Empty" to create new disks
  disk_size_gb        = var.data_disks[count.index].disk_size_gb
}


# Attach Data Disks
resource "azurerm_virtual_machine_data_disk_attachment" "data_disks" {
  count                = length(var.data_disks)
  managed_disk_id      = azurerm_managed_disk.data_disks[count.index].id
  virtual_machine_id   = azurerm_linux_virtual_machine.contoh.id
  lun                  = var.data_disks[count.index].lun
  caching              = var.data_disks[count.index].caching
}
