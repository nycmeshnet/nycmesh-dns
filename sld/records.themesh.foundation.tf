# https://github.com/nycmeshnet/themesh.foundation/blob/main/CNAME

resource "namedotcom_record" "themesh_foundation_A_108" {
  domain_name = "themesh.foundation"
  host        = ""
  record_type = "A"
  answer      = "185.199.108.153"
}

resource "namedotcom_record" "themesh_foundation_A_109" {
  domain_name = "themesh.foundation"
  host        = ""
  record_type = "A"
  answer      = "185.199.109.153"
}

resource "namedotcom_record" "themesh_foundation_A_110" {
  domain_name = "themesh.foundation"
  host        = ""
  record_type = "A"
  answer      = "185.199.110.153"
}

resource "namedotcom_record" "themesh_foundation_A_111" {
  domain_name = "themesh.foundation"
  host        = ""
  record_type = "A"
  answer      = "185.199.111.153"
}

resource "namedotcom_record" "themesh_foundation_www_cname" {
  domain_name = "themesh.foundation"
  host        = "www"
  record_type = "CNAME"
  answer      = "nycmeshnet.github.io"
}
