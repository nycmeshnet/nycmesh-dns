# Pointed to github pages
# https://github.com/nycmeshnet/connect-redirect

resource "namedotcom_record" "A_108" {
  domain_name = "nycmeshconnect.com"
  host        = ""
  record_type = "A"
  answer      = "185.199.108.153"
}

resource "namedotcom_record" "A_109" {
  domain_name = "nycmeshconnect.com"
  host        = ""
  record_type = "A"
  answer      = "185.199.109.153"
}

resource "namedotcom_record" "A_110" {
  domain_name = "nycmeshconnect.com"
  host        = ""
  record_type = "A"
  answer      = "185.199.110.153"
}

resource "namedotcom_record" "A_111" {
  domain_name = "nycmeshconnect.com"
  host        = ""
  record_type = "A"
  answer      = "185.199.111.153"
}

resource "namedotcom_record" "nycmeshconnect_com_www_cname" {
  domain_name = "nycmeshconnect.com"
  host        = "www"
  record_type = "CNAME"
  answer      = "nycmeshnet.github.io"
}

# Authoritative DNS server at SN3
resource "namedotcom_record" "nycmesh-713-dns-auth-3-nycmeshconnect-com" {
  domain_name = "nycmeshconnect.com"
  host        = "nycmesh-713-dns-auth-3"
  record_type = "A"
  answer      = "199.170.132.47"
}
