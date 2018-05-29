variable "mariadb-version" {
  description = "mariadb version to use for fetching the docker image"
  default     = "10.2.14"
}

variable "ips" {
  type = "map"
}

variable "mysql_root_password" {}
