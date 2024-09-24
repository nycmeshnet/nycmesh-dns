module "some_mesh_dns_servers" {
  source = "./mesh_dns_servers"

  mesh_dns_local_password         = var.mesh_dns_local_password
  influx_db_token                 = var.influx_db_token
  proxmox_node                    = var.proxmox_node
  proxmox_template_image          = "debian-cloud"
  proxmox_storage_location        = var.proxmox_storage_location
  dns_local_user                  = "debian"
  dns_auth_mgt_ip                 = var.dns_auth_mgt_ip
  dns_rec_mgt_ip                  = var.dns_rec_mgt_ip
  dns_auth_internal_ip            = var.dns_auth_internal_ip
  dns_rec_internal_ip             = var.dns_rec_internal_ip
  dns_auth_external_ip            = var.dns_auth_external_ip
  dns_rec_external_ip             = var.dns_rec_external_ip
  dns_mgt_network_prefix          = var.dns_mgt_network_prefix
  dns_mgt_network_host_identifier = var.dns_mgt_network_host_identifier
  dns_mgt_gateway                 = var.dns_mgt_gateway
  dns_ssh_key_name                = "dns_ed25519"
  hostname_prefix                 = var.hostname_prefix
  hostname_count_offset           = var.hostname_count_offset
  recursive_cores                 = var.recursive_cores
  recursive_sockets               = var.recursive_sockets
  recursive_memory                = var.recursive_memory
  vm_nic                          = var.vm_nic
  datadog_api_key                 = var.datadog_api_key
  datadog_site                    = var.datadog_site
}
