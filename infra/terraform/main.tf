terraform {
  backend "s3" {
    key    = "terraform/state/dns4.tfstate"
    region = "us-east-1"
  }
  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  # Configuration options
  pm_api_url = "https://${var.proxmox_host}:8006/api2/json"
  # TODO: Setup cert
  pm_tls_insecure     = true
  pm_debug            = true
  pm_api_token_id     = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
}
