proxmox_node             = "nycmesh-10-r630-01"
proxmox_storage_location = "local-lvm"
vm_nic                   = "vmbr1"
dns_auth_mgt_ip = [
  "10.70.100.43",
  "10.70.100.52",
]
dns_rec_mgt_ip = [
  "10.70.100.44",
  "10.70.100.53",
]
dns_auth_router_ip = [
  "10.70.100.54",
  "10.70.100.55",
]
dns_rec_router_ip = [
  "10.70.100.56",
  "10.70.100.57",
]
dns_auth_internal_ip = [
  "10.70.100.45",
  "10.70.100.45",
]
dns_rec_internal_ip = [
  "10.70.90.133",
  "10.70.90.133",
]
dns_auth_external_ip = [
  "23.158.16.23",
  "199.170.132.47",
]
dns_rec_external_ip = [
  "", # Blank so it is not created
  "", # Blank so it is not created
]
dns_rec_outgoing_ip = [
  "23.158.16.25",
  "23.158.16.26",
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
