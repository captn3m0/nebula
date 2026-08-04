terraform {
  required_version = ">= 1.3.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    pass = {
      source = "camptocamp/pass"
    }
  }
}

provider "kubernetes" {
  config_path = "../../digitalocean/kubeconfig"
}

provider "pass" {
}
