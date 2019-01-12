resource "docker_container" "bootkube" {
  image = "${docker_image.image.latest}"
  name  = "bootkube-render"

  volumes {
    container_path = "/home/.bootkube"
    volume_name    = "${var.asset_dir_volume_name}"
  }

  command = [
    "bootkube",
    "${var.mode}",
    "--asset-dir=/home/.bootkube",
    "--api-servers=https://kubernetes.default:${var.host_port},https://${var.k8s_host},https://${var.host_ip}:${var.host_port}",
    "--pod-cidr=${var.pod_cidr}",
  ]

  # "--service-cidr=${var.service_cidr}",
  restart         = "on-failure"
  max_retry_count = 5
}

data "docker_registry_image" "image" {
  name = "captn3m0/bootkube:v${var.version}"
}

resource "docker_image" "image" {
  name          = "${data.docker_registry_image.image.name}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
}
