module "outline" {
  source                   = "modules/outline"
  smtp_password            = "${data.pass_password.outline_smtp_password.password}"
  secret_key               = "${data.pass_password.outline_secret_key.password}"
  slack_key                = "${data.pass_password.outline_slack_key.password}"
  slack_secret             = "${data.pass_password.outline_slack_secret.password}"
  slack_app_id             = "${data.pass_password.outline_slack_app_id.password}"
  slack_verification_token = "${data.pass_password.outline_slack_verification_token.password}"
  hostname                 = "outline.${var.root-domain}"
}
