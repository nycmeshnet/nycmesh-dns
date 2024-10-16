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

variable "proxmox_token_id" {
  type        = string
  description = "proxmox server token id"
}

variable "proxmox_token_secret" {
  type        = string
  description = "proxmox server token secret"
}

variable "proxmox_node" {
  type        = string
  description = "target node on the proxmox server"
}

variable "proxmox_storage_location" {
  type        = string
  description = "target resource pool on the proxmox server"
  default     = "local-lvm"
}

variable "mesh_dns_local_password" {
  type        = string
  description = "password of the local user for the vm"
  sensitive   = true
}

variable "influx_db_token" {
  type        = string
  description = "token for influx db"
  sensitive   = true
}

variable "datadog_api_key" {
  type        = string
  description = "API key for datadog"
  sensitive   = true
}

variable "datadog_site" {
  type        = string
  description = "URL for datadog"
  default     = "us5.datadoghq.com"
}

variable "dns_auth_mgt_ip" {
  type        = list(any)
  description = "management IPs for the authoritative dns vm(s)"
}

variable "dns_rec_mgt_ip" {
  type        = list(any)
  description = "management IPs for the recursive dns vm(s)"
}

variable "dns_auth_internal_ip" {
  type        = list(any)
  description = "internal listen IPs for the authoritative dns vm(s)"
}

variable "dns_rec_internal_ip" {
  type        = list(any)
  description = "internal listen IPs for the recursive dns vm(s)"
}

variable "dns_auth_external_ip" {
  type        = list(any)
  description = "external listen IPs for the authoritative dns vm(s), empty string for none"
}

variable "dns_rec_external_ip" {
  type        = list(any)
  description = "external listen IPs for the recursive dns vm(s), empty string for none"
}

variable "dns_mgt_network_prefix" {
  type        = string
  description = "network range to use for intneral networking"
}

variable "dns_mgt_network_host_identifier" {
  type        = string
  description = "default network range for the vm"
}

variable "dns_mgt_gateway" {
  type        = string
  description = "default gateway for the vm"
}

variable "vm_nic" {
  type        = string
  description = "nic for the vms"
  default     = "vmbr0"
}

variable "hostname_prefix" {
  type        = string
  description = "previous dns hosts (this + index)"
  default     = 0
}

variable "hostname_count_offset" {
  type        = number
  description = "prefix for the VM hostnames"
  default     = 0
}

variable "recursive_cores" {
  type        = string
  description = "cpu core count"
  default     = 2
}
variable "recursive_sockets" {
  type        = string
  description = "socket count"
  default     = 1
}

variable "recursive_memory" {
  type        = string
  description = "RAM MB count"
  default     = 2560
}

variable "authoritative_cores" {
  type        = string
  description = "cpu core count"
  default     = 2
}

variable "authoritative_sockets" {
  type        = string
  description = "socket count"
  default     = 1
}

variable "authoritative_memory" {
  type        = string
  description = "RAM MB count"
  default     = 2560
}

variable "dns_cookie_secret" {
  type        = string
  description = "0x{32 hex chars} used for secret for dns cookies"
  sensitive   = true
}
