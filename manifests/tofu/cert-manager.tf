resource "kubernetes_secret_v1" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token"
    namespace = "cert-manager"
  }

  data = {
    api-token = data.terraform_remote_state.cloudflare.outputs.cert_manager_cloudflare_token
  }

  type = "Opaque"
}
