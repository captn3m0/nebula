terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}
