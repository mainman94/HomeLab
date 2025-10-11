terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.84.1"
    }
  }
}


provider "proxmox" {
  endpoint = var.pve_endpoint

  # TODO: use terraform variable or remove the line, and use PROXMOX_VE_USERNAME environment variable
  username = var.pve_username
  # TODO: use terraform variable or remove the line, and use PROXMOX_VE_PASSWORD environment variable
  password = var.pve_password

  # because self-signed TLS certificate is in use
  insecure = true
  # uncomment (unless on Windows...)
  # tmp_dir  = "/var/tmp"
  
  ssh {
    agent = true
   }

}