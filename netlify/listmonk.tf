# listmonk on the k3s cluster (manifests/listmonk), and what the website's digest function needs to reach it
resource "netlify_dns_record" "lists" {
  type     = "A"
  zone_id  = data.netlify_dns_zone.blr_today.id
  hostname = "lists.blr.today"
  value    = "139.59.48.222"
}

data "pass_password" "listmonk_web" {
  path = "blr.today/listmonk-api-web"
}

locals {
  listmonk_env = {
    LISTMONK_URL              = "https://lists.blr.today"
    LISTMONK_API_USER         = data.pass_password.listmonk_web.data["user"]
    LISTMONK_API_TOKEN        = trimspace(data.pass_password.listmonk_web.password)
    LISTMONK_LIST_ID          = data.pass_password.listmonk_web.data["list_id"]
    LISTMONK_LINK_TEMPLATE_ID = data.pass_password.listmonk_web.data["link_template_id"]
  }
}

resource "netlify_environment_variable" "listmonk" {
  for_each = local.listmonk_env
  team_id  = "5a2d2d35df99534c1cda3053"
  site_id  = "22e12fee-effc-43e9-a409-2c0d2e8d7602"
  key      = each.key
  values   = [{ value = each.value, context = "all" }]
}
