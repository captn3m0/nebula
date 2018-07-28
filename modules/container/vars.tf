variable "image" {
  description = "docker image (with tag)"
}

variable "name" {
  description = "docker container name"
}

variable "ports" {
  description = "list of port mappings"
  type        = "list"
  default     = []
}

variable "networks" {
  description = "list of networks"
  type        = "list"
  default     = []
}

variable "restart" {
  description = "restart-policy"
  default     = "unless-stopped"
}

variable "must_run" {
  description = "If true, then the Docker container will be kept running. "
  default     = "true"
  type        = "string"
}

variable "user" {
  description = "user"
  default     = ""
}

variable "destroy_grace_seconds" {
  description = "Container will be destroyed after n seconds or on successful stop."
  default     = 10
  type        = "string"
}

variable "command" {
  description = "command"
  default     = []
}

variable "entrypoint" {
  description = "entrypoint"
  default     = []
}

variable "env" {
  description = "environment variables"
  default     = []
}

variable "labels" {
  description = "labels"
  default     = {}
}
