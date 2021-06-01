
# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.8.0"
    }
  }
}

variable "do_fp" { sensitive = true }    #ssh-key fingerprint
variable "do_token" { sensitive = true } #api-access token

variable "region" { default = "fra1" }
variable "size" { default = "s-1vcpu-1gb" }
variable "name" { default = "IaC-Test-2" }

resource "digitalocean_droplet" "node" {
  count  = 3
  image  = "ubuntu-20-04-x64"
  name   = var.name
  region = var.region
  size   = var.size
  ssh_keys = [
    var.do_fp
  ]
}

module "web-server" {
  count      = 3
  source     = "./web-server"
  ip_address = element(digitalocean_droplet.node.*.ipv4_address, count.index)
  server_number = count.index
}

output "ip_address" {
  value = digitalocean_droplet.node.*.ipv4_address
}
