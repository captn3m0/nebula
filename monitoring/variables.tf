variable "gf-security-admin-password" {
  type = "string"
}

# variable "email" {
#   type = "string"
# }

variable "domain" {
  type = "string"
}

variable "alert-slack-username" {
  default = "Prometheus"
}

variable "alert-slack-channel" {
  default = "#notifications"
}

variable "alert-slack-incoming-webhook" {
  default = "https://hooks.slack.com/whatever"
}
