proxmox_node             = "nycmesh-10-r630-01"
proxmox_storage_location = "local-lvm"
vm_nic                   = "vmbr1"
dns_auth_mgt_ip = [
  "10.70.100.43",
]
dns_rec_mgt_ip = [
  "10.70.100.44",
]
dns_auth_internal_ip = [
  "10.70.100.45",
]
dns_rec_internal_ip = [
  "10.70.90.133",
]
dns_auth_external_ip = [
  "23.158.16.23",
]
dns_rec_external_ip = [
  "", # Blank so it is not created
]
dns_mgt_network_prefix          = "10.70.100.0"
dns_mgt_network_host_identifier = "24"
dns_mgt_gateway                 = "10.70.100.1"
hostname_prefix                 = "nycmesh-10"
hostname_count_offset           = 4
recursive_cores                 = 5
recursive_sockets               = 1
recursive_memory                = 4096
enable_doh                      = "enable"
