variable "stack" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "os_disk_size_gb" {
  type = number
}

variable "os_disk_type" {
  type = string
}

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}

variable "image_version" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "custom_data" {
  type = string
}

variable "ssh_key_data" {
  type = string
}

variable "nic_configs" {
  type = list(object({
    id = string
  }))
}

variable "data_disks" {
  description = "List of data disks to attach to the VM"
  type = list(object({
    lun                 = number
    caching             = string
    disk_size_gb        = number
    storage_account_type = string
  }))
  default = []
}

variable "tags" {
  type = map(string)
  default = {}
}