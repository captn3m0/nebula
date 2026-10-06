terraform {
  required_version = ">= 1.3.0"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    pass = {
      source = "camptocamp/pass"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "kubernetes" {
  config_path = "../../digitalocean/kubeconfig"
}

provider "pass" {
}
