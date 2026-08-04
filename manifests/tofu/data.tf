data "terraform_remote_state" "cloudflare" {
  backend = "s3"

  config = {
    bucket  = "nebula-301109182511-eu-central-1-an"
    key     = "terraform/cloudflare.tfstate"
    region  = "eu-central-1"
    profile = "nebula"
  }
}
