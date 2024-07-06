resource "ansible_group" "knot-recursive" {
  name = "knot-recursive"
  variables = {
    ansible_user                 = var.dns_local_user
    ansible_ssh_private_key_file = "../terraform/${var.dns_ssh_key_name}"
    ansible_ssh_common_args      = "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
  }
}

resource "ansible_group" "knot-authoritative" {
  name = "knot-authoritative"
  variables = {
    ansible_user                 = var.dns_local_user
    ansible_ssh_private_key_file = "../terraform/${var.dns_ssh_key_name}"
    ansible_ssh_common_args      = "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
  }
}

resource "ansible_host" "rec-dns-mgt" {
  count  = 1
  name   = var.dns_rec_mgt_ip[count.index]
  groups = [ansible_group.knot-recursive.name]
  variables = {
    SERVER_HOSTNAME                  = "gordian-knot-rec-${count.index}"
    EXTERNAL_LISTEN_IP               = var.dns_rec_external_ip[count.index]
    INTERNAL_NETWORK_RANGE           = format("%s/%s", var.dns_mgt_network_prefix, var.dns_mgt_network_host_identifier)
    INTERNAL_NETWORK_HOST_IDENTIFIER = var.dns_mgt_network_host_identifier
    INTERNAL_LISTEN_IP               = var.dns_rec_internal_ip[count.index]
    INTERNAL_MGT_IP                  = var.dns_rec_mgt_ip[count.index]
    INTERNAL_MGT_DG                  = var.dns_mgt_gateway
  }
}

resource "ansible_host" "auth-dns-mgt" {
  count  = 1
  name   = var.dns_auth_mgt_ip[count.index]
  groups = [ansible_group.knot-authoritative.name]
  variables = {
    SERVER_HOSTNAME                  = "gordian-knot-auth-${count.index}"
    EXTERNAL_LISTEN_IP               = var.dns_auth_external_ip[count.index]
    INTERNAL_NETWORK_RANGE           = format("%s/%s", var.dns_mgt_network_prefix, var.dns_mgt_network_host_identifier)
    INTERNAL_NETWORK_HOST_IDENTIFIER = var.dns_mgt_network_host_identifier
    INTERNAL_LISTEN_IP               = var.dns_auth_internal_ip[count.index]
    INTERNAL_MGT_IP                  = var.dns_auth_mgt_ip[count.index]
    INTERNAL_MGT_DG                  = var.dns_mgt_gateway
  }
}
