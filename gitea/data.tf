# https://github.com/go-gitea/gitea/releases
data "docker_registry_image" "gitea" {
  # not bleeding, this is hemorrhaging edge
  name = "gitea/gitea:latest"
}

data "docker_registry_image" "redis" {
  name = "redis:alpine"
}

data "template_file" "gitea-config-file" {
  template = "${file("${path.module}/conf/conf.ini.tpl")}"

  vars {
    secret_key     = "${var.secret-key}"
    internal_token = "${var.internal-token}"
    smtp_password  = "${var.smtp-password}"
    lfs-jwt-secret = "${var.lfs-jwt-secret}"
    mysql-password = "${var.mysql-password}"
  }
}
