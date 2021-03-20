data "docker_registry_image" "image" {
  name = var.image
}

resource "docker_image" "image" {
  name          = var.image
  pull_triggers = [data.docker_registry_image.image.sha256_digest]
  keep_locally  = var.keep_image
}

data "docker_network" "traefik" {
  name = "traefik"
}

resource "docker_container" "container" {
  name  = var.name
  image = docker_image.image.latest
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

  network_mode = var.network_mode

  dynamic "capabilities" {
    for_each = [var.capabilities]
    content {
      add  = lookup(capabilities.value, "add", [])
      drop = lookup(capabilities.value, "drop", [])
    }
  }

  dynamic "networks_advanced" {
    for_each = [var.networks_advanced]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      aliases      = lookup(networks_advanced.value, "aliases", null)
      ipv4_address = lookup(networks_advanced.value, "ipv4_address", null)
      ipv6_address = lookup(networks_advanced.value, "ipv6_address", null)
      name         = networks_advanced.value.name
    }
  }

  memory      = local.resource["memory"]
  memory_swap = local.resource["memory_swap"]

  dynamic "volumes" {
    for_each = [var.volumes]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      container_path = lookup(volumes.value, "container_path", null)
      from_container = lookup(volumes.value, "from_container", null)
      host_path      = lookup(volumes.value, "host_path", null)
      read_only      = lookup(volumes.value, "read_only", null)
      volume_name    = lookup(volumes.value, "volume_name", null)
    }
  }
  dynamic "devices" {
    for_each = [var.devices]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      container_path = lookup(devices.value, "container_path", null)
      host_path      = devices.value.host_path
      permissions    = lookup(devices.value, "permissions", null)
    }
  }

  dynamic "upload" {
    for_each = [var.uploads]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      content        = lookup(upload.value, "content", null)
      content_base64 = lookup(upload.value, "content_base64", null)
      executable     = lookup(upload.value, "executable", null)
      file           = upload.value.file
      source         = lookup(upload.value, "source", null)
      source_hash    = lookup(upload.value, "source_hash", null)
    }
  }

  # Look at this monstrosity
  # And then https://github.com/hashicorp/terraform/issues/12453#issuecomment-365569618
  # for why this is needed

  dynamic "labels" {
    for_each = merge(
      local.default_labels,
      zipmap(
        concat(
          keys(local.default_labels),
          split(
            "~",
            lookup(var.web, "expose", "false") == "false" ? "" : join("~", keys(local.traefik_common_labels)),
          ),
        ),
        concat(
          values(local.default_labels),
          split(
            "~",
            lookup(var.web, "expose", "false") == "false" ? "" : join("~", values(local.traefik_common_labels)),
          ),
        ),
      ),
      zipmap(
        concat(
          keys(local.default_labels),
          split(
            "~",
            lookup(var.web, "expose", "false") == "false" ? "" : join("~", keys(local.web)),
          ),
        ),
        concat(
          values(local.default_labels),
          split(
            "~",
            lookup(var.web, "expose", "false") == "false" ? "" : join("~", values(local.web)),
          ),
        ),
      ),
      zipmap(
        concat(
          keys(local.default_labels),
          split(
            "~",
            lookup(var.web, "expose", "false") == "false" ? "" : join("~", keys(local.traefik_common_labels)),
          ),
        ),
        concat(
          values(local.default_labels),
          split(
            "~",
            lookup(var.web, "expose", "false") == "false" ? "" : join("~", values(local.traefik_common_labels)),
          ),
        ),
      ),
      zipmap(
        concat(
          keys(local.default_labels),
          split(
            "~",
            lookup(var.web, "auth", "false") == "false" ? "" : join("~", keys(local.traefik_auth_labels)),
          ),
        ),
        concat(
          values(local.default_labels),
          split(
            "~",
            lookup(var.web, "auth", "false") == "false" ? "" : join("~", values(local.traefik_auth_labels)),
          ),
        ),
      ),
    )
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      label = labels.value.label
      value = labels.value.value
    }
  }

  destroy_grace_seconds = var.destroy_grace_seconds
  must_run              = var.must_run
}

