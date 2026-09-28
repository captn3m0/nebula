data "pass_password" "nextdns_api" {
  path = "Keys/NEXTDNS_API"
}

resource "kubernetes_secret_v1" "nextdns_api" {
  metadata {
    name      = "nextdns-api"
    namespace = "nextdns"
  }

  data = {
    api-key = data.pass_password.nextdns_api.password
  }

  type = "Opaque"
}
