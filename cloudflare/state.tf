terraform {
  backend "s3" {
    bucket  = "nebula-301109182511-eu-central-1-an"
    key     = "terraform/cloudflare.tfstate"
    region  = "eu-central-1"
    profile = "nebula"
  }
}
