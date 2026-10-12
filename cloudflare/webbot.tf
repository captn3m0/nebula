# Web Bot Auth key directory for the blr.today crawler, proxied from blr.today by Netlify
data "cloudflare_zone" "bb8" {
  name = var.domain
}

data "pass_password" "web_bot_auth" {
  path = "blr.today/web-bot-auth"
}

resource "cloudflare_workers_script" "webbot" {
  account_id         = data.cloudflare_zone.bb8.account_id
  name               = "blr-today-webbot"
  content            = file("${path.module}/webbot/worker.js")
  module             = true
  compatibility_date = "2026-10-01"

  secret_text_binding {
    name = "WEB_BOT_AUTH_KEY"
    text = data.pass_password.web_bot_auth.full
  }

  plain_text_binding {
    name = "AUTHORITY"
    text = "blr.today"
  }
}

resource "cloudflare_workers_domain" "webbot" {
  account_id = data.cloudflare_zone.bb8.account_id
  zone_id    = data.cloudflare_zone.bb8.id
  hostname   = "webbot.${var.domain}"
  service    = cloudflare_workers_script.webbot.name
}

output "web_bot_auth_directory" {
  value = "https://${cloudflare_workers_domain.webbot.hostname}/.well-known/http-message-signatures-directory"
}
