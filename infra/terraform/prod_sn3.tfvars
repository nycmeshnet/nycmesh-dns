proxmox_node             = "nycmesh-713-r640-02"
proxmox_storage_location = "local-lvm"
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
hostname_prefix                 = "nycmesh-713"
hostname_count_offset           = 2
recursive_cores                 = 5
recursive_sockets               = 1
recursive_memory                = 4096
