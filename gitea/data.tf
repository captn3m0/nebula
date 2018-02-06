# https://github.com/go-gitea/gitea/releases
data "docker_registry_image" "gitea" {
  name = "gitea/gitea:1.4"
}

data "template_file" "gitea-config-file" {
  template = "${file("${path.module}/conf/conf.ini.tpl")}"

  vars {
    secret_key     = "${var.secret-key}"
    internal_token = "${var.internal-token}"
    smtp_password  = "${var.smtp-password}"
  }
}
