module "prod_mesh_dns_servers" {
  source = "./mesh_dns_servers"

  providers = {
    proxmox = proxmox.prod
  }

  MESH_DNS_LOCAL_PASSWORD  = var.MESH_DNS_LOCAL_PASSWORD
  INFLUX_DB_TOKEN          = var.INFLUX_DB_TOKEN
  proxmox_node             = "nycmesh-713-r640-02"
  proxmox_template_image   = "debian-cloud"
  proxmox_storage_location = "local-lvm"
  dns_local_user           = "debian"
  vm_nic                   = "vmbr0v32"
  dns_auth_mgt_ip = [
    "10.70.90.130",
  ]
  dns_rec_mgt_ip = [
    "10.70.90.131",
  ]
  dns_auth_internal_ip = [
    "10.70.90.132",
  ]
  dns_rec_internal_ip = [
    "10.70.90.133",
  ]
  dns_auth_external_ip = [
    "199.170.132.47",
  ]
  dns_rec_external_ip = [
    "", # Blank so it is not created
  ]
  dns_mgt_network_prefix          = "10.70.90.0"
  dns_mgt_network_host_identifier = "24"
  dns_mgt_gateway                 = "10.70.90.1"
  dns_ssh_key_name                = "dns_ed25519"
  hostname_prefix                 = "nycmesh-713"
  hostname_count_offset           = 2
  recursive_cores                 = 5
  recursive_sockets               = 1
  recursive_memory                = 4096
}

#output "jon_dns_auth_instance_id" {
#  value = module.jon_mesh_dns_servers.authoritative_instance_id
#}

#output "jon_dns_rec_instance_id" {
#  value = module.jon_mesh_dns_servers.recursive_instance_id
#}