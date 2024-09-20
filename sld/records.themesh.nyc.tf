# https://github.com/nycmeshnet/themesh.nyc/blob/main/CNAME

resource "namedotcom_record" "themesh_A_108" {
  domain_name = "themesh.nyc"
  host        = ""
  record_type = "A"
  answer      = "185.199.108.153"
}

resource "namedotcom_record" "themesh_A_109" {
  domain_name = "themesh.nyc"
  host        = ""
  record_type = "A"
  answer      = "185.199.109.153"
}

resource "namedotcom_record" "themesh_A_110" {
  domain_name = "themesh.nyc"
  host        = ""
  record_type = "A"
  answer      = "185.199.110.153"
}

resource "namedotcom_record" "themesh_A_111" {
  domain_name = "themesh.nyc"
  host        = ""
  record_type = "A"
  answer      = "185.199.111.153"
}

resource "namedotcom_record" "themesh_nyc_www_cname" {
  domain_name = "themesh.nyc"
  host        = "www"
  record_type = "CNAME"
  answer      = "nycmeshnet.github.io"
}
