data "docker_registry_image" "timemachine" {
  name = "odarriba/timemachine:latest"
}

resource "docker_image" "timemachine" {
  name          = data.docker_registry_image.timemachine.name
  pull_triggers = [data.docker_registry_image.timemachine.sha256_digest]
}

resource "docker_container" "timemachine" {
  name  = "timemachine"
  image = docker_image.timemachine.image_id

  volumes {
    host_path      = "/mnt/xwing/data/timemachine"
    container_path = "/timemachine"
  }

  ports {
    internal = 548
    external = 548
    ip       = var.ips["eth0"]
  }

  ports {
    internal = 636
    external = 636
    ip       = var.ips["eth0"]
  }

  upload {
    content = data.template_file.timemachine-entrypoint.rendered
    file    = "/entrypoint-custom.sh"
  }

  entrypoint = [
    "/bin/sh",
    "/entrypoint-custom.sh",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

data "template_file" "timemachine-entrypoint" {
  template = file("${path.module}/entrypoint.sh.tpl")

  vars = {
    username-1 = var.username-1
    password-1 = var.password-1
    username-2 = var.username-2
    password-2 = var.password-2
  }
}

