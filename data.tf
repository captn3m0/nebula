data "docker_network" "bridge" {
  name = "bridge"
}

data "terraform_remote_state" "digitalocean" {
  backend = "s3"

  config = {
    bucket  = "nebula-301109182511-eu-central-1-an"
    key     = "terraform/digitalocean.tfstate"
    region  = "eu-central-1"
    profile = "nebula"
  }
}
