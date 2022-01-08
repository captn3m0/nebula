terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
