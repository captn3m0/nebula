# Cloudflare API token for the tatooine.club zone (account 34c97bfc648a63e10eb2a368ad302011).

data "pass_password" "certmanager_tatooine_token" {
  path = "Nebula/CERTMANAGER_TATOOINE"
}

resource "kubernetes_secret_v1" "cloudflare_api_token_tatooine" {
  metadata {
    name      = "cloudflare-api-token-tatooine"
    namespace = "cert-manager"
  }

  data = {
    api-token = data.pass_password.certmanager_tatooine_token.password
  }

  type = "Opaque"
}
