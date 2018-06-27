variable "mariadb-version" {
  description = "mariadb version to use for fetching the docker image"
  default     = "10.2.14"
}

variable "postgres-version" {
  description = "postgres version to use for fetching the docker image"
  default     = "10-alpine"
}

variable "ips" {
  type = "map"
}

variable "mysql_root_password" {}
variable "postgres-root-password" {}
