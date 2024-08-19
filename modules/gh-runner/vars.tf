variable "name" {
  type = string
  description = "name of the runner, typically the org or the org-repo"
}

variable "url" {
  type = string
  description = "either https://github.com/org or github.com/org/repo"
}

variable "runner_version" {
  type = string
  description = "runner version from https://ghcr.io/actions/actions-runner"
  default = "2.317.0"
}

variable "token" {
  type = string
  description = "GitHub Actions Runner Token"
  sensitive = true
}
