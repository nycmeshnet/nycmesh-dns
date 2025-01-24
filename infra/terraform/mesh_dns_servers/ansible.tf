resource "ansible_group" "knot-recursive" {
  name = "knot-recursive"
  variables = {
    ansible_user                 = var.dns_local_user
    ansible_ssh_private_key_file = "../terraform/${var.dns_ssh_key_name}"
    ansible_ssh_common_args      = "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
    telegraf_knot                = ""
    telegraf_kresd               = "enable"
    DOH_SERVER                   = var.enable_doh
    MAIN_AUTH_SERVER_DOH         = var.main_auth_server_ip
    TSIG_KEY_DOH                 = var.tsig_key_doh
    MESH_STUB_RESOLVER           = var.mesh_stub_resolver
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
    DNS_COOKIE_SECRET            = var.dns_cookie_secret
    TSIG_KEY_GRANDMOX            = var.tsig_key_grandmox
    TSIG_KEY_JON                 = var.tsig_key_jon
    TSIG_KEY_10_R630_01          = var.tsig_key_10_r630_01
    TSIG_KEY_713_R640_01         = var.tsig_key_713_r640_01
    TSIG_KEY_DOH                 = var.tsig_key_doh
  }
}

resource "ansible_host" "rec-dns-mgt" {
  count  = length(var.dns_rec_mgt_ip)
  name   = var.dns_rec_mgt_ip[count.index]
  groups = [ansible_group.knot-recursive.name]
  variables = {
    SERVER_HOSTNAME                  = "${var.hostname_prefix}-dns-rec-${sum([1, count.index, var.hostname_count_offset])}"
    ROUTER_IP                        = var.dns_rec_router_ip[count.index]
    EXTERNAL_LISTEN_IP               = var.dns_rec_external_ip[count.index]
    EXTERNAL_OUTGOING_IP             = var.dns_rec_outgoing_ip[count.index]
    INTERNAL_NETWORK_RANGE           = format("%s/%s", var.dns_mgt_network_prefix, var.dns_mgt_network_host_identifier)
    INTERNAL_NETWORK_HOST_IDENTIFIER = var.dns_mgt_network_host_identifier
    INTERNAL_LISTEN_IP               = var.dns_rec_internal_ip[count.index]
    INTERNAL_MGT_IP                  = var.dns_rec_mgt_ip[count.index]
    INTERNAL_MGT_DG                  = var.dns_mgt_gateway
    INFLUX_DB_TOKEN                  = var.influx_db_token
    LOCAL_PASSWORD                   = var.mesh_dns_local_password
    DATADOG_API_KEY                  = var.datadog_api_key
    DATADOG_SITE                     = var.datadog_site
    CERTBOT_UPDATE_HOUR              = tostring(sum([1, count.index, var.hostname_count_offset]))
  }
}

resource "ansible_host" "auth-dns-mgt" {
  count  = length(var.dns_auth_mgt_ip)
  name   = var.dns_auth_mgt_ip[count.index]
  groups = [ansible_group.knot-authoritative.name]
  variables = {
    SERVER_HOSTNAME                  = "${var.hostname_prefix}-dns-auth-${sum([1, count.index, var.hostname_count_offset])}"
    ROUTER_IP                        = var.dns_auth_router_ip[count.index]
    EXTERNAL_LISTEN_IP               = var.dns_auth_external_ip[count.index]
    EXTERNAL_OUTGOING_IP             = ""
    INTERNAL_NETWORK_RANGE           = format("%s/%s", var.dns_mgt_network_prefix, var.dns_mgt_network_host_identifier)
    INTERNAL_NETWORK_HOST_IDENTIFIER = var.dns_mgt_network_host_identifier
    INTERNAL_LISTEN_IP               = var.dns_auth_internal_ip[count.index]
    INTERNAL_MGT_IP                  = var.dns_auth_mgt_ip[count.index]
    INTERNAL_MGT_DG                  = var.dns_mgt_gateway
    INFLUX_DB_TOKEN                  = var.influx_db_token
    LOCAL_PASSWORD                   = var.mesh_dns_local_password
    DATADOG_API_KEY                  = var.datadog_api_key
    DATADOG_SITE                     = var.datadog_site
  }
}
