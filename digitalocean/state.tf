terraform {
  backend "s3" {
    bucket  = "nebula-301109182511-eu-central-1-an"
    key     = "terraform/digitalocean.tfstate"
    region  = "eu-central-1"
    profile = "nebula"
  }
}
