terraform {
  backend "s3" {
    # Chang to the path to use within your bucket
    key    = "terraform/state/nycmesh-sld.tfstate"
    region = "us-east-1"
  }
  required_providers {
    namedotcom = {
      source  = "lexfrei/namedotcom"
      version = "1.3.1"
    }
  }
}

provider "namedotcom" {
  username = var.name_dot_com_user
  token    = var.name_dot_com_token
}
