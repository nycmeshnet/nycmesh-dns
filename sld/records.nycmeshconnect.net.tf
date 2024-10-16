# Pointed to github pages
# https://github.com/nycmeshnet/connect/blob/main/CNAME

resource "namedotcom_record" "record__240356243" {
  domain_name = "nycmeshconnect.net"
  host        = ""
  record_type = "A"
  answer      = "185.199.108.153"
}

resource "namedotcom_record" "record__240356247" {
  domain_name = "nycmeshconnect.net"
  host        = ""
  record_type = "A"
  answer      = "185.199.109.153"
}

resource "namedotcom_record" "record__240356249" {
  domain_name = "nycmeshconnect.net"
  host        = ""
  record_type = "A"
  answer      = "185.199.110.153"
}

resource "namedotcom_record" "record__240356250" {
  domain_name = "nycmeshconnect.net"
  host        = ""
  record_type = "A"
  answer      = "185.199.111.153"
}

resource "namedotcom_record" "nycmeshconnect_net_www_cname" {
  domain_name = "nycmeshconnect.net"
  host        = "www"
  record_type = "CNAME"
  answer      = "nycmeshnet.github.io"
}

# Authoritative DNS server at SN3
resource "namedotcom_record" "nycmesh-713-dns-auth-4-nycmeshconnect-net" {
  domain_name = "nycmeshconnect.net"
  host        = "nycmesh-713-dns-auth-4"
  record_type = "A"
  answer      = "199.170.132.47"
}
