variable "proxmox_node" {
  type        = string
  description = "target node on the proxmox server"
  default     = "jon"
}

variable "proxmox_template_image" {
  type        = string
  description = "name of the template you have already setup in proxmox"
  default     = "debian-cloud"
}

variable "proxmox_storage_location" {
  type        = string
  description = "target resource pool on the proxmox server"
  default     = "local-lvm"
}

variable "dns_local_user" {
  type        = string
  description = "default user for the vm"
  default     = "debian"
}

variable "mesh_dns_local_password" {
  type        = string
  description = "password of the local user for the vm"
  sensitive   = true
}

variable "dns_auth_mgt_ip" {
  type        = list(any)
  description = "management IPs for the authoritative dns vm(s)"
}

variable "dns_rec_mgt_ip" {
  type        = list(any)
  description = "management IPs for the recursive dns vm(s)"
}

variable "dns_auth_router_ip" {
  type        = list(string)
  description = "ospf router IDs for the authoritative dns vm(s)"
}

variable "bird_network" {
  type        = string
  description = "bird ospf network for dns vm(s)"
  default     = "10.69.0.0/16"
}

variable "dns_rec_router_ip" {
  type        = list(string)
  description = "ospf router IDs for the recursive dns vm(s)"
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

variable "dns_rec_outgoing_ip" {
  type        = list(any)
  description = "external IPs used to resolve recursive dns queries, empty string for none"
}

variable "dns_mgt_network_host_identifier" {
  type        = string
  description = "default network range for the vm"
}

variable "dns_mgt_gateway" {
  type        = string
  description = "default gateway for the vm"
}

variable "dns_ssh_key_name" {
  type        = string
  description = "ssh key name"
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

variable "tsig_key_building" {
  type        = string
  description = "TSIG key for the building.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "tsig_key_jamesinternaldev3" {
  type        = string
  description = "TSIG key for the jamesinternaldev3.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "tsig_key_jamesinternalprod2" {
  type        = string
  description = "TSIG key for the jamesinternalprod2.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "tsig_key_grandmox" {
  type        = string
  description = "TSIG key for the grandmox.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "tsig_key_jon" {
  type        = string
  description = "TSIG key for the jon.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "tsig_key_10_r630_01" {
  type        = string
  description = "TSIG key for the nycmesh-10-r630-01.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "tsig_key_713_r640_01" {
  type        = string
  description = "TSIG key for the nycmesh-713-r640-01.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "tsig_key_doh" {
  type        = string
  description = "TSIG key for the doh.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "tsig_key_ha" {
  type        = string
  description = "TSIG key for the ha.mesh.nycmesh.net zone"
  sensitive   = true
}

variable "enable_doh" {
  type        = string
  description = "Enable doh server on recursive resolver"
  default     = ""
}

variable "main_auth_server_ip" {
  type        = string
  description = "authoritative server IP to use for DoH certs"
}

variable "mesh_stub_resolver" {
  type        = string
  description = "resolver for mesh bound queries"
}

variable "bird_ospf_cost" {
  type        = string
  description = "OSPF cost for only bird"
  default     = "10"
}
