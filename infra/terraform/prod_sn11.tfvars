proxmox_node             = "nycmesh-sn11-prodvms1"
proxmox_storage_location = "local-lvm"
vm_nic                   = "vmbr0"
dns_auth_mgt_ip = [
]
dns_rec_mgt_ip = [
  "10.70.104.22",
  "10.70.104.24",
]
dns_auth_router_ip = [
]
dns_rec_router_ip = [
  "10.70.104.23",
  "10.70.104.25",
]
dns_auth_internal_ip = [
]
dns_rec_internal_ip = [
  //"10.10.10.10",
  //"10.10.10.11",
  "10.70.104.26",
  "10.70.104.27",
]
dns_auth_external_ip = [
]
dns_rec_external_ip = [
  "", # Blank so it is not created
  "", # Blank so it is not created
]
dns_rec_outgoing_ip = [
  "", # Blank so it is not created
  "", # Blank so it is not created
]
dns_mgt_network_host_identifier = "24"
dns_mgt_gateway                 = "10.70.104.1"
hostname_prefix                 = "nycmesh-11"
hostname_count_offset           = 6
recursive_cores                 = 5
recursive_sockets               = 1
recursive_memory                = 4096
enable_doh                      = ""
mesh_stub_resolver              = "199.170.132.47"
