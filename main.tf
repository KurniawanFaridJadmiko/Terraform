provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "contoh" {
  name     = "humanai-rg-prod-southeastasia"
  location = "Southeast Asia"
}

# Virtual Network
resource "azurerm_virtual_network" "contoh" {
  name                = "humanai-vnet-prod-southeastasia"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.contoh.location
  resource_group_name = azurerm_resource_group.contoh.name
}

# Subnet
resource "azurerm_subnet" "contoh" {
  name                 = "humanai-subnet-prod-southeastasia"
  resource_group_name  = azurerm_resource_group.contoh.name
  virtual_network_name = azurerm_virtual_network.contoh.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "contoh" {
  name                = "humanai-nsg-prod-southeastasia"
  location            = azurerm_resource_group.contoh.location
  resource_group_name = azurerm_resource_group.contoh.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Public IP
resource "azurerm_public_ip" "contoh" {
  name                = "humanai-ip-prod-southeastasia"
  location            = azurerm_resource_group.contoh.location
  resource_group_name = azurerm_resource_group.contoh.name
  allocation_method   = "Dynamic"
}

# Network Interface
resource "azurerm_network_interface" "contoh" {
  name                = "humanai-nic-prod-southeastasia"
  location            = azurerm_resource_group.contoh.location
  resource_group_name = azurerm_resource_group.contoh.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.contoh.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.contoh.id
  }
}

# Association of NSG to Network Interface
resource "azurerm_network_interface_security_group_association" "contoh" {
  network_interface_id      = azurerm_network_interface.contoh.id
  network_security_group_id = azurerm_network_security_group.contoh.id
}

# Virtual Machine Module
module "azure_vm" {
  source              = "./azure_vm_module"
  stack               = "humanai"
  environment         = "prod"
  region              = "southeastasia"
  resource_group_name = azurerm_resource_group.contoh.name
  location            = azurerm_resource_group.contoh.location
  vm_size             = "Standard_DS1_v2"
  os_disk_size_gb     = 30
  os_disk_type        = "Premium_LRS"
  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_sku           = "18.04-LTS"
  image_version       = "latest"
  admin_username      = "adminuser"
  custom_data         = filebase64("cloud-init.txt")
  ssh_key_data        = file("~/.ssh/id_rsa.pub")
  nic_configs         = [
    {
      id = azurerm_network_interface.contoh.id
    }
  ]
  data_disks = [
    {
      lun                 = 0
      caching             = "ReadWrite"
      disk_size_gb        = 10
      storage_account_type = "Standard_LRS"
    }
  ]
  tags = {}  # Or define any tags you need
}
