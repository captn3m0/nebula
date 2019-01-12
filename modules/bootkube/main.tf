resource "docker_container" "render" {
  count = "${var.mode == "render" ? 1 : 0}"
  image = "${docker_image.image.latest}"
  name  = "bootkube-render"

  volumes {
    container_path = "/home/.bootkube"
    volume_name    = "/etc/kube-assets"
  }

  command = [
    "bootkube",
    "render",
    "--etcd-servers=http://${host_ip}:2379",
    "--asset-dir=/home/.bootkube",
    "--api-servers=https://kubernetes.default:${var.host_port},https://${var.k8s_host}:${var.host_port},https://${var.host_ip}:${var.host_port}",
    "--pod-cidr=${var.pod_cidr}",
    "--network-provider=${var.network_provider}",
  ]

  network_mode    = "host"
  restart         = "on-failure"
  max_retry_count = 5
}

resource "docker_container" "start" {
  count = "${var.mode == "start" ? 1 : 0}"
  image = "${docker_image.image.latest}"
  name  = "bootkube-${var.mode}"

  volumes {
    container_path = "/home/.bootkube"
    volume_name    = "/etc/kube-assets"
    read_only      = true
  }

  volumes {
    container_path = "/etc/kubernetes"
    host_path      = "/etc/kubernetes"
  }

  # "There is no war within the container. Here we are safe. Here we are free."
  # - Docker Li agent brainwashing Nemo
  command = [
    "bootkube",
    "start",
    "--asset-dir=/home/.bootkube",
  ]

  network_mode    = "host"
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
