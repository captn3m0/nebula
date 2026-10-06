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
  }
}

provider "pass" {
}

provider "netlify" {
  token = trimspace(data.pass_password.netlify_token.password)
}

data "pass_password" "netlify_token" {
  path = "Keys/NETLIFY"
}
