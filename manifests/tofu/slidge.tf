data "pass_password" "slidge_bridge_password" {
  path = "Nebula/slidge-bridge-password"
}

data "pass_password" "slidge_zulip_api_key" {
  path = "Nebula/slidge-zulip-api-key"
}

data "pass_password" "slidge_component_secret" {
  path = "Nebula/slidge-component-secret"
}

resource "kubernetes_secret_v1" "slidge_zulip_runtime" {
  metadata {
    name      = "slidge-zulip-slidge-zulip-runtime"
    namespace = "slidge"
  }

  data = {
    bridge-password  = trimspace(data.pass_password.slidge_bridge_password.password)
    zulip-api-key    = trimspace(data.pass_password.slidge_zulip_api_key.password)
    component-secret = trimspace(data.pass_password.slidge_component_secret.password)
  }

  type = "Opaque"
}
