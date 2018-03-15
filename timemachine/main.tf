data "docker_registry_image" "timemachine" {
  name = "odarriba/timemachine:latest"
}

resource "docker_image" "timemachine" {
  name          = "${data.docker_registry_image.timemachine.name}"
  pull_triggers = ["${data.docker_registry_image.timemachine.sha256_digest}"]
}

resource docker_container "timemachine" {
  name  = "timemachine"
  image = "${docker_image.timemachine.latest}"

  volumes {
    host_path      = "/mnt/xwing/data/timemachine"
    container_path = "/timemachine"
  }

  ports {
    internal = 548
    external = 548
    ip       = "${var.ips["eth0"]}"
  }

  ports {
    internal = 636
    external = 636
    ip       = "${var.ips["eth0"]}"
  }

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}
