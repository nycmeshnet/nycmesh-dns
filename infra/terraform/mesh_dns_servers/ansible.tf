resource "ansible_group" "knot-recursive" {
  name = "knot-recursive"
  variables = {
    ansible_user                 = var.dns_local_user
    ansible_ssh_private_key_file = "../terraform/${var.dns_ssh_key_name}"
    ansible_ssh_common_args      = "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
    telegraf_knot                = ""
    telegraf_kresd               = "enable"
    DOH_SERVER                   = "enable"
  }
}

resource "ansible_group" "knot-authoritative" {
  name = "knot-authoritative"
  variables = {
    ansible_user                 = var.dns_local_user
    ansible_ssh_private_key_file = "../terraform/${var.dns_ssh_key_name}"
    ansible_ssh_common_args      = "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
    telegraf_knot                = "enable"
    telegraf_kresd               = ""
    DOH_SERVER                   = ""
  }
}

resource "ansible_host" "rec-dns-mgt" {
  count  = 1
  name   = var.dns_rec_mgt_ip[count.index]
  groups = [ansible_group.knot-recursive.name]
  variables = {
    SERVER_HOSTNAME                  = "${var.hostname_prefix}-dns-rec-${sum([1, count.index, var.hostname_count_offset])}"
    EXTERNAL_LISTEN_IP               = var.dns_rec_external_ip[count.index]
    INTERNAL_NETWORK_RANGE           = format("%s/%s", var.dns_mgt_network_prefix, var.dns_mgt_network_host_identifier)
    INTERNAL_NETWORK_HOST_IDENTIFIER = var.dns_mgt_network_host_identifier
    INTERNAL_LISTEN_IP               = var.dns_rec_internal_ip[count.index]
    INTERNAL_MGT_IP                  = var.dns_rec_mgt_ip[count.index]
    INTERNAL_MGT_DG                  = var.dns_mgt_gateway
    INFLUX_DB_TOKEN                  = var.INFLUX_DB_TOKEN
  }
}

resource "ansible_host" "auth-dns-mgt" {
  count  = 1
  name   = var.dns_auth_mgt_ip[count.index]
  groups = [ansible_group.knot-authoritative.name]
  variables = {
    SERVER_HOSTNAME                  = "${var.hostname_prefix}-dns-auth-${sum([1, count.index, var.hostname_count_offset])}"
    EXTERNAL_LISTEN_IP               = var.dns_auth_external_ip[count.index]
    INTERNAL_NETWORK_RANGE           = format("%s/%s", var.dns_mgt_network_prefix, var.dns_mgt_network_host_identifier)
    INTERNAL_NETWORK_HOST_IDENTIFIER = var.dns_mgt_network_host_identifier
    INTERNAL_LISTEN_IP               = var.dns_auth_internal_ip[count.index]
    INTERNAL_MGT_IP                  = var.dns_auth_mgt_ip[count.index]
    INTERNAL_MGT_DG                  = var.dns_mgt_gateway
    INFLUX_DB_TOKEN                  = var.INFLUX_DB_TOKEN
  }
}
