resource "docker_container" "container" {
  name  = var.name
  image = docker_image.image.image_id

  dynamic "ports" {
    for_each = var.ports
    content {
      external = ports.value.external
      internal = ports.value.internal
      ip       = ports.value.ip
      protocol = lookup(ports.value, "protocol", "tcp")
    }
  }
  restart    = var.restart
  env        = var.env
  command    = var.command
  entrypoint = var.entrypoint
  user       = var.user
  dns        = var.dns

  privileged = var.privileged

  network_mode = var.network_mode

  gpus = var.gpu ? "all" : ""

  dynamic "capabilities" {
    for_each = [var.capabilities]
    content {
      add  = lookup(capabilities.value, "add", [])
      drop = lookup(capabilities.value, "drop", [])
    }
  }

  dynamic "networks_advanced" {
    for_each = local.networks
    content {
      name = networks_advanced.value
    }
  }

  memory      = local.resource["memory"]
  memory_swap = local.resource["memory_swap"]

  dynamic "volumes" {
    for_each = var.volumes
    content {
      container_path = lookup(volumes.value, "container_path", null)
      from_container = lookup(volumes.value, "from_container", null)
      host_path      = lookup(volumes.value, "host_path", null)
      read_only      = lookup(volumes.value, "read_only", null)
      volume_name    = lookup(volumes.value, "volume_name", null)
    }
  }

  dynamic "devices" {
    for_each = var.devices
    content {
      host_path      = devices.value["host_path"]
      container_path = devices.value["container_path"]
      permissions    = devices.value["permissions"]
    }
  }

  dynamic "upload" {
    for_each = var.uploads
    content {
      file           = lookup(upload.value, "file", null)
      content        = lookup(upload.value, "content", null)
      content_base64 = lookup(upload.value, "content_base64", null)
      executable     = lookup(upload.value, "executable", null)
      source         = lookup(upload.value, "source", null)
      source_hash    = lookup(upload.value, "source_hash", null)
    }
  }

  dynamic "labels" {
    for_each = local.labels
    content {
      label = labels.key
      value = labels.value
    }
  }

  destroy_grace_seconds = var.destroy_grace_seconds
  must_run              = var.must_run
}
