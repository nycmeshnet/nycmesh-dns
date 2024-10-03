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
