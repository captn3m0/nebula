variable "smtp_username" {
  default = "outline@mail.captnemo.in"
}

variable "smtp_password" {}

variable "smtp_email" {
  default = "outline@mail.captnemo.in"
}

variable "reply_email" {
  default = "outline@captnemo.in"
}

variable "db_host" {
  default = "postgres"
}

variable "db_name" {
  default = "outline"
}

variable "db_name_test" {
  default = "outline-test"
}

variable "db_port" {
  default = "5432"
}

variable "db_username" {
  default = "outline"
}

variable "cache_port" {
  default = "6379"
}

variable "cache_host" {
  default = "outline-redis"
}

variable "secret_key" {}

variable "slack_key" {}
variable "slack_secret" {}
variable "slack_app_id" {}
variable "slack_verification_token" {}

variable "hostname" {}
