data "pass_password" "zulip2tg_zulip_key" {
  path = "Nebula/zulip2tg-zulip-key"
}

data "pass_password" "zulip2tg_telegram_bot_token" {
  path = "Nebula/zulip2tg-telegram-bot-token"
}

resource "kubernetes_secret_v1" "zulip2tg_config" {
  metadata {
    name      = "zulip2tg-config"
    namespace = "slidge"
  }

  data = {
    "config.yaml" = templatefile("${path.module}/../zulip2tg/config.yaml.tftpl", {
      zulip_key          = trimspace(data.pass_password.zulip2tg_zulip_key.password)
      telegram_bot_token = trimspace(data.pass_password.zulip2tg_telegram_bot_token.password)
    })
  }

  type = "Opaque"
}
