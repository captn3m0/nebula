data "cloudflare_api_token_permission_groups" "all" {}

resource "cloudflare_api_token" "cert_manager" {
  name = "cert-manager-dns01-bb8"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
      data.cloudflare_api_token_permission_groups.all.zone["Zone Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.${lookup(data.cloudflare_zones.bb8.zones[0], "id")}" = "*"
    }
  }
}

output "cert_manager_cloudflare_token" {
  value     = cloudflare_api_token.cert_manager.value
  sensitive = true
}
