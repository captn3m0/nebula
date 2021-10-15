terraform {
  required_version = ">= 1.0.7"
  experiments      = [module_variable_optional_attrs]
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}
