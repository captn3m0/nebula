# https://github.com/go-gitea/gitea/releases
data "docker_registry_image" "gitea" {
  name = "gitea/gitea:latest"

  # Currently on latest master to avoid https://github.com/go-gitea/gitea/issues/5704
  # name = "gitea/gitea:1.7"
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
