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

# Personal token NEBULA_NETLIFY (no expiry) from https://app.netlify.com/user/applications
data "pass_password" "netlify_token" {
  path = "Nebula/NETLIFY_ACCESS_TOKEN"
}
