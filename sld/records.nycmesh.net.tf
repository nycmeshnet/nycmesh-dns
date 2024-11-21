# Main website
resource "namedotcom_record" "record__983532" {
  domain_name = "nycmesh.net"
  host        = ""
  record_type = "A"
  answer      = "104.198.14.52"
}

# Main website
resource "namedotcom_record" "record_www_983538" {
  domain_name = "nycmesh.net"
  host        = "www"
  record_type = "CNAME"
  answer      = "clever-shannon-d43dce.netlify.com"
}

# Future subdomain for the wiki
resource "namedotcom_record" "record_wiki_1031824" {
  domain_name = "nycmesh.net"
  host        = "wiki"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

# SPF (email)
resource "namedotcom_record" "record__983545" {
  domain_name = "nycmesh.net"
  host        = ""
  record_type = "TXT"
  answer      = "v=spf1 include:mailgun.org include:servers.mcsv.net ~all"
}

# DMARC (email)
resource "namedotcom_record" "record__dmarc_3745600" {
  domain_name = "nycmesh.net"
  host        = "_dmarc"
  record_type = "TXT"
  answer      = "v=DMARC1; p=none"
}

# DKIM (email)
resource "namedotcom_record" "record_k1_domainkey_3735562" {
  domain_name = "nycmesh.net"
  host        = "k1._domainkey"
  record_type = "CNAME"
  answer      = "dkim.mcsv.net"
}

# MX record for email
resource "namedotcom_record" "record__983546" {
  domain_name = "nycmesh.net"
  host        = ""
  record_type = "MX"
  answer      = "mxa.mailgun.org"
}

# MX record for email
resource "namedotcom_record" "record__983547" {
  domain_name = "nycmesh.net"
  host        = ""
  record_type = "MX"
  answer      = "mxb.mailgun.org"
}

# Site verification for mailgun. Only modify if you know what you're doing.
resource "namedotcom_record" "record_pic_domainkey_1171425" {
  domain_name = "nycmesh.net"
  host        = "pic._domainkey"
  record_type = "TXT"
  answer      = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSJLcgGjVDfFSpXdVnaz0DdvJeRj7yhcuJjXRUV85TeEOCbNgDcVQXrVJeC/J0z8iiwJAl9gDEf8L729r54VJ/y8ml+xxjIp3hDBIm0Pg9TiTVGO9kif9RlW2unIrGKw2CrE7xM7vZcpw2FQt3fJwZtZ8zBOn68sIU9stR9MUG+QIDAQAB"
}

# Email subdomain
resource "namedotcom_record" "record_email_1171426" {
  domain_name = "nycmesh.net"
  host        = "email"
  record_type = "CNAME"
  answer      = "mailgun.org"
}

resource "namedotcom_record" "record_375pearl_1367535" {
  domain_name = "nycmesh.net"
  host        = "375pearl"
  record_type = "A"
  answer      = "206.130.10.151"
}

resource "namedotcom_record" "record_375pearl_1367537" {
  domain_name = "nycmesh.net"
  host        = "375pearl"
  record_type = "AAAA"
  answer      = "2001:504:36::c2ab:0:1"
}

resource "namedotcom_record" "record__now_3070265" {
  domain_name = "nycmesh.net"
  host        = "_now"
  record_type = "TXT"
  answer      = "f12798020e735de0ae0fac869c386d7e676ac3b828953712b0f28bd718848c14"
}

# Docs site
resource "namedotcom_record" "record_docs_3526857" {
  domain_name = "nycmesh.net"
  host        = "docs"
  record_type = "CNAME"
  answer      = "quirky-edison-0960a5.netlify.com"
}

# OS Ticket (IPv4)
resource "namedotcom_record" "record_support_3588805" {
  domain_name = "nycmesh.net"
  host        = "support"
  record_type = "A"
  answer      = "165.227.70.230"
}

# OS Ticket (IPv6)
resource "namedotcom_record" "record_support_3588806" {
  domain_name = "nycmesh.net"
  host        = "support"
  record_type = "AAAA"
  answer      = "2604:a880:800:10::9f0:3001"
}

# Dev OS Ticket
resource "namedotcom_record" "record_devsupport_4727325" {
  domain_name = "nycmesh.net"
  host        = "devsupport"
  record_type = "A"
  answer      = "157.245.9.130"
}

# rDNS
resource "namedotcom_record" "record_ipv4_3588972" {
  domain_name = "nycmesh.net"
  host        = "ipv4"
  record_type = "NS"
  answer      = "ns-518.awsdns-00.net"
}

# rDNS
resource "namedotcom_record" "record_ipv4_3588978" {
  domain_name = "nycmesh.net"
  host        = "ipv4"
  record_type = "NS"
  answer      = "ns-1709.awsdns-21.co.uk"
}

# rDNS
resource "namedotcom_record" "record_ipv4_3588980" {
  domain_name = "nycmesh.net"
  host        = "ipv4"
  record_type = "NS"
  answer      = "ns-432.awsdns-54.com"
}

# rDNS
resource "namedotcom_record" "record_ipv4_3588982" {
  domain_name = "nycmesh.net"
  host        = "ipv4"
  record_type = "NS"
  answer      = "ns-1346.awsdns-40.org"
}

resource "namedotcom_record" "record_donate2_3618629" {
  domain_name = "nycmesh.net"
  host        = "donate2"
  record_type = "A"
  answer      = "165.227.181.4"
}

resource "namedotcom_record" "record_unifi_3862748" {
  domain_name = "nycmesh.net"
  host        = "unifi"
  record_type = "A"
  answer      = "10.70.90.158"
}

# Private recursive resolver at SN1
resource "namedotcom_record" "record_nycmesh-375p-dns1-resolver_5233305" {
  domain_name = "nycmesh.net"
  host        = "nycmesh-375p-dns1-resolver"
  record_type = "A"
  answer      = "199.167.59.10"
}

# NS record for the mesh.nycmesh.net zone
resource "namedotcom_record" "record_mesh_5226462" {
  domain_name = "nycmesh.net"
  host        = "mesh"
  record_type = "NS"
  answer      = "nycmesh-375p-dns1-authoritative.nycmesh.net"
}

# Authoritative DNS server for the mesh.nycmesh.net zone at SN1
resource "namedotcom_record" "record_nycmesh-375p-dns1-authoritative_5233306" {
  domain_name = "nycmesh.net"
  host        = "nycmesh-375p-dns1-authoritative"
  record_type = "A"
  answer      = "199.167.59.11"
}

# Authoritative DNS server for the mesh.nycmesh.net zone at SN3
resource "namedotcom_record" "nycmesh-713-dns-auth-4" {
  domain_name = "nycmesh.net"
  host        = "nycmesh-713-dns-auth-4"
  record_type = "A"
  answer      = "199.170.132.47"
}

# Slack redirect
resource "namedotcom_record" "record_slack_5235473" {
  domain_name = "nycmesh.net"
  host        = "slack"
  record_type = "CNAME"
  answer      = "nycmesh-slack-redirect.netlify.com"
}

# https://configgen.nycmesh.net
resource "namedotcom_record" "record_configgen_5386032" {
  domain_name = "nycmesh.net"
  host        = "configgen"
  record_type = "CNAME"
  answer      = "nycmesh-configgen.netlify.com"
}

# Offline as of 9/2/24
resource "namedotcom_record" "record_monitoring_6041298" {
  domain_name = "nycmesh.net"
  host        = "monitoring"
  record_type = "A"
  answer      = "147.75.67.41"
}

# Redirects to https://github.com/meshcenter/mesh-api
resource "namedotcom_record" "record_api_7081451" {
  domain_name = "nycmesh.net"
  host        = "api"
  record_type = "CNAME"
  answer      = "nycmesh-api.netlify.com"
}

# Dashboard service (DigitalOcean)
resource "namedotcom_record" "record_dashboard_7092840" {
  domain_name = "nycmesh.net"
  host        = "dashboard"
  record_type = "CNAME"
  answer      = "nycmesh-dashboard.netlify.com"
}

# Site verification for github. Only modify if you know what you're doing.
resource "namedotcom_record" "record__github-challenge-nycmeshnet_194338752" {
  domain_name = "nycmesh.net"
  host        = "_github-challenge-nycmeshnet"
  record_type = "TXT"
  answer      = "91a37d19f2"
}

# Site verification for google. Only modify if you know what you're doing.
resource "namedotcom_record" "record__2193735" {
  domain_name = "nycmesh.net"
  host        = ""
  record_type = "TXT"
  answer      = "google-site-verification=ZqOjueV-PhiukY-NDTf8CbGOPFwzGqeeIwmDQC-ZdRc"
}

# Site verification for google. Only modify if you know what you're doing.
resource "namedotcom_record" "record__3686691" {
  domain_name = "nycmesh.net"
  host        = ""
  record_type = "TXT"
  answer      = "google-site-verification=bpTWn9VyMNrKSypwCvf-lWaiuO3IuTay6cqvKVud1po"
}

# Site verification for google. Only modify if you know what you're doing.
resource "namedotcom_record" "record__206768814" {
  domain_name = "nycmesh.net"
  host        = ""
  record_type = "TXT"
  answer      = "google-site-verification=-6nHnrb5t1xNkD9zHiJm9hYTlAP7seIk-WLVaB1OveU"
}

# Mastodon
resource "namedotcom_record" "record_mastodon_219371939" {
  domain_name = "nycmesh.net"
  host        = "mastodon"
  record_type = "A"
  answer      = "199.170.132.101"
}

# Alternate domain for for Mastodon
resource "namedotcom_record" "record_social_219371944" {
  domain_name = "nycmesh.net"
  host        = "social"
  record_type = "A"
  answer      = "199.170.132.101"
}

# Typo helper for Mastodon
resource "namedotcom_record" "record_mastadon_219988024" {
  domain_name = "nycmesh.net"
  host        = "mastadon"
  record_type = "A"
  answer      = "199.170.132.101"
}

# Stripe redirect
resource "namedotcom_record" "record_stripeportal_222339638" {
  domain_name = "nycmesh.net"
  host        = "stripeportal"
  record_type = "CNAME"
  answer      = "nycmesh-stripe-redirect.netlify.app"
}

# Invoice Ninja
resource "namedotcom_record" "record_ninja_226273090" {
  domain_name = "nycmesh.net"
  host        = "ninja"
  record_type = "A"
  answer      = "165.227.70.230"
}

# Status page
resource "namedotcom_record" "record_status_238885567" {
  domain_name = "nycmesh.net"
  host        = "status"
  record_type = "A"
  answer      = "164.92.117.225"
}

# Test record, feel free to remove
resource "namedotcom_record" "record__123" {
  answer      = "127.0.0.1"
  domain_name = "nycmesh.net"
  host        = "jamestest"
  record_type = "A"
}

###### k8s stateless services ######
resource "namedotcom_record" "k8s_stateless_services_prod" {
  domain_name = "nycmesh.net"
  host        = "k8s-stateless-prod"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

resource "namedotcom_record" "k8s_stateless_services_dev" {
  domain_name = "nycmesh.net"
  host        = "k8s-stateless-dev"
  record_type = "CNAME"
  answer      = "kubernetes-lb-jon-sn3.nycmesh.net"
}

###### Meshdb Prod ######
resource "namedotcom_record" "meshdb_prod_k8s_lb" {
  domain_name = "nycmesh.net"
  host        = "kubernetes-lb-prod-sn3"
  record_type = "A"
  answer      = "199.170.132.45"
}

resource "namedotcom_record" "meshdb_prod_meshdb" {
  domain_name = "nycmesh.net"
  host        = "db"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

resource "namedotcom_record" "meshdb_prod_map" {
  domain_name = "nycmesh.net"
  host        = "map.db"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

resource "namedotcom_record" "meshdb_prod_adminmap" {
  domain_name = "nycmesh.net"
  host        = "adminmap.db"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

resource "namedotcom_record" "meshdb_prod_los-backend" {
  domain_name = "nycmesh.net"
  host        = "los-backend.db"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

resource "namedotcom_record" "record_los_6530453" {
  domain_name = "nycmesh.net"
  host        = "los"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

resource "namedotcom_record" "meshdb_prod_forms" {
  domain_name = "nycmesh.net"
  host        = "forms"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

# (New) Grafana at sn3-esxi [hosted on sn3-k8s]
resource "namedotcom_record" "record_stats_new" {
  domain_name = "nycmesh.net"
  host        = "stats-new"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

# Public grafana
resource "namedotcom_record" "record_stats_cname" {
  domain_name = "nycmesh.net"
  host        = "stats"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

###### Meshdb Dev ######
resource "namedotcom_record" "meshdb_dev_k8s_lb" {
  domain_name = "nycmesh.net"
  host        = "kubernetes-lb-jon-sn3"
  record_type = "A"
  answer      = "199.170.132.46"
}

resource "namedotcom_record" "devdb" {
  domain_name = "nycmesh.net"
  host        = "devdb"
  record_type = "CNAME"
  answer      = "kubernetes-lb-jon-sn3.nycmesh.net"
}

resource "namedotcom_record" "devdb_all" {
  domain_name = "nycmesh.net"
  host        = "*.devdb"
  record_type = "CNAME"
  answer      = "kubernetes-lb-jon-sn3.nycmesh.net"
}

resource "namedotcom_record" "gsg_displays" {
  domain_name = "nycmesh.net"
  host        = "gsg-displays"
  record_type = "A"
  answer      = "199.170.132.101"
}

###### Website Map ######
resource "namedotcom_record" "website_map" {
  domain_name = "nycmesh.net"
  host        = "map"
  record_type = "CNAME"
  answer      = "kubernetes-lb-prod-sn3.nycmesh.net"
}

resource "namedotcom_record" "website_map_dev" {
  domain_name = "nycmesh.net"
  host        = "devmap"
  record_type = "CNAME"
  answer      = "kubernetes-lb-jon-sn3.nycmesh.net"
}
