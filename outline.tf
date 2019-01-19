module "outline" {
  source                   = "modules/outline"
  smtp_password            = "${var.outline_smtp_password}"
  secret_key               = "${var.outline_secret_key}"
  slack_key                = "${var.outline_slack_key}"
  slack_secret             = "${var.outline_slack_secret}"
  slack_app_id             = "${var.outline_slack_app_id}"
  slack_verification_token = "${var.outline_slack_verification_token}"
  hostname                 = "outline.${var.root-domain}"
}
