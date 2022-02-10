
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_versions" "current" {}

resource "digitalocean_kubernetes_cluster" "k8s_cluster" {
  name   = var.cluster_name
  region = var.cluster_region

  version = data.digitalocean_kubernetes_versions.current.latest_version

  node_pool {
    name       = "${var.cluster_name}-pool"
    size       = var.node_size
    node_count = var.node_count
  }
}
