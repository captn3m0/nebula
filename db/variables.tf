variable "postgres-version" {
  description = "postgres version to use for fetching the docker image"
  default     = "14-alpine"
}

variable "ips" {
  type = map(string)
}

variable "postgres-root-password" {
}
