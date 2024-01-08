variable "image" {
  description = "docker image (with tag)"
}

variable "name" {
  description = "docker container name"
}

variable "ports" {
  description = "list of port mappings"
  type        = list(map(string))
  default     = []
}

variable "networks" {
  description = "list of names of networks to attach to"
  type        = list(string)
  default     = []
}

variable "restart" {
  description = "restart-policy"
  default     = "unless-stopped"
}

variable "must_run" {
  description = "If true, then the Docker container will be kept running. "
  default     = "true"
  type        = string
}

variable "user" {
  description = "user"
  default     = ""
}

variable "destroy_grace_seconds" {
  description = "Container will be destroyed after n seconds or on successful stop."
  default     = 10
  type        = string
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
  default = {}
}

variable "xpoweredby" {
  default = "X-Powered-By:Allomancy||X-Server:Blackbox"
}

variable "web" {
  description = "Web Configuration"
  type = object({
    expose   = bool
    auth     = optional(bool)
    port     = optional(number)
    host     = optional(string)
    protocol = optional(string)
  })

  default = {
    expose   = false
    auth     = false
    port     = 80
    host     = ""
    protocol = "http"
  }
}

variable "auth_header" {
  default = "tatooine:$2y$05$iPbatint3Gulbs6kUtyALO9Yq5sBJ..aiF82bcIziH4ytz9nFoPr6,reddit:$2y$05$ghKxSydYCpAT8r2VVMDmWO/BBecghGfLsRJUkr3ii7XxPyxBqp8Oy"
}

variable "network_mode" {
  default = "bridge"
}

variable "resource" {
  description = "Resource usage for the container"

  default = {}
}

variable "volumes" {
  description = "volumes"
  default     = {}
}

variable "privileged" {
  description = "  If true, the container runs in privileged mode."
  default = false
}

variable "capabilities" {
  description = "capabilities"

  default = {
    add  = []
    drop = []
  }
}

variable "devices" {
  description = "list of devices"
  type        = list(map(string))

  default = []
}

variable "keep_image" {
  description = "keep image, don't delete"
  default     = false
}

variable "uploads" {
  description = "Files to Upload"
  type = list(object({
    file           = string
    content        = optional(string)
    content_base64 = optional(string)
    executable     = optional(bool)
    source         = optional(string)
    source_hash    = optional(string)
  }))

  default = []
}

variable "gpu" {
  type = bool
  default  = false
}

variable "dns" {
  description = "set of dns servers"
  default = []
}
