data "pass_password" "cloudflare_key_traefik" {
  path = "Nebula/CLOUDFLARE_KEY"
}

resource "kubernetes_secret_v1" "traefik_cloudflare" {
  metadata {
    name      = "traefik-cloudflare-credentials"
    namespace = "kube-system"
  }

  data = {
    CF_API_EMAIL = "bb8@captnemo.in"
    CF_API_KEY   = data.pass_password.cloudflare_key_traefik.password
  }

  type = "Opaque"
}
