variable "postgres-version" {
  description = "postgres version to use for fetching the docker image"
  default     = "10-alpine"
}

variable "ips" {
  type = "map"
}

variable "postgres-root-password" {}
