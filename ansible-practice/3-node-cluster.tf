terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "main" {
  image  = "ubuntu-18-04-x64"
  name   = "main"
  region = "blr1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [33094158]
}

resource "digitalocean_droplet" "targets" {
  image  = "ubuntu-18-04-x64"
  count = 2
  name   = "target-${count.index}"
  region = "blr1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [33094158]
}

