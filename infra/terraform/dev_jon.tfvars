proxmox_node             = "jon"
proxmox_storage_location = "local-lvm"
dns_auth_mgt_ip = [
  "10.70.90.134",
]
dns_rec_mgt_ip = [
  "10.70.90.135",
]
dns_auth_router_ip = [
  "10.70.90.183",
]
dns_rec_router_ip = [
  "10.70.90.184",
]
dns_auth_internal_ip = [
  "10.70.90.136",
]
dns_rec_internal_ip = [
  "10.70.90.133",
]
dns_auth_external_ip = [
  "199.170.132.48",
]
dns_rec_external_ip = [
  "", # Blank so it is not created
]
dns_rec_outgoing_ip = [
  "199.170.132.41", # Blank so it is not created
]
dns_mgt_network_host_identifier = "24"
dns_mgt_gateway                 = "10.70.90.1"
hostname_prefix                 = "nycmesh-713-jon"
hostname_count_offset           = 0
recursive_cores                 = 4
recursive_sockets               = 1
recursive_memory                = 4096
enable_doh                      = ""
#mesh_stub_resolver              = "23.158.16.23"
