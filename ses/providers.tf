terraform {
  required_version = ">= 1.3.0"
  required_providers {
    pass = {
      source = "camptocamp/pass"
    }
    netlify = {
      source  = "netlify/netlify"
      version = "~> 0.4"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "pass" {
}

provider "netlify" {
  token = trimspace(data.pass_password.netlify_token.password)
}

provider "aws" {
  region  = "ap-south-1"
  profile = var.aws_profile
}

variable "aws_profile" {
  type    = string
  default = "nebula"
}

# Personal token NEBULA_NETLIFY (no expiry) from https://app.netlify.com/user/applications
data "pass_password" "netlify_token" {
  path = "Nebula/NETLIFY_ACCESS_TOKEN"
}
