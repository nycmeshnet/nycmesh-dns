variable "proxmox_host" {
  type        = string
  description = "ip/domain of the proxmox server"
  default     = "10.70.90.52"
}

variable "proxmox_prod_host" {
  type        = string
  description = "ip/domain of the proxmox server"
  default     = "10.70.90.195"
}

variable "PROXMOX_TOKEN_ID" {
  type        = string
  description = "proxmox server token id"
}

variable "PROXMOX_TOKEN_SECRET" {
  type        = string
  description = "proxmox server token secret"
}

variable "PROD_PROXMOX_TOKEN_ID" {
  type        = string
  description = "proxmox server token id"
}

variable "PROD_PROXMOX_TOKEN_SECRET" {
  type        = string
  description = "proxmox server token secret"
}

variable "MESH_DNS_LOCAL_PASSWORD" {
  type        = string
  description = "password of the local user for the vm"
  sensitive   = true
}

variable "INFLUX_DB_TOKEN" {
  type        = string
  description = "token for influx db"
  sensitive   = true
}

variable "vm_nic" {
  type        = string
  description = "nic for the vms"
  default     = "vmbr0"
}