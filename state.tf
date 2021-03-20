terraform {
  backend "s3" {
    bucket  = "rmx-nemo"
    key     = "terraform/nebula.tfstate"
    region  = "ap-south-1"
    profile = "nebula"
  }
}

