resource "aws_iam_user" "smtp" {
  name = "ses-smtp-blr-today"
}

data "aws_iam_policy_document" "smtp" {
  statement {
    actions = ["ses:SendRawEmail", "ses:SendEmail"]
    resources = concat([
      aws_sesv2_email_identity.blr_today.arn,
      aws_sesv2_configuration_set.weekly.arn,
      # In the sandbox SES also checks the verified recipient's identity
    ], [for r in aws_sesv2_email_identity.test_recipient : r.arn])
  }
}

resource "aws_iam_user_policy" "smtp" {
  name   = "ses-send-blr-today"
  user   = aws_iam_user.smtp.name
  policy = data.aws_iam_policy_document.smtp.json
}

resource "aws_iam_access_key" "smtp" {
  user = aws_iam_user.smtp.name
}

resource "pass_password" "smtp" {
  path     = "blr.today/ses-smtp"
  password = aws_iam_access_key.smtp.ses_smtp_password_v4
  data = {
    username   = aws_iam_access_key.smtp.id
    host       = "email-smtp.${data.aws_region.current.region}.amazonaws.com"
    port       = "587"
    tls        = "STARTTLS"
    config_set = local.config_set
  }
}

resource "aws_sns_topic_subscription" "listmonk" {
  count                  = var.listmonk_webhook_enabled ? 1 : 0
  topic_arn              = aws_sns_topic.ses_events.arn
  protocol               = "https"
  endpoint               = "https://lists.blr.today/webhooks/service/ses"
  endpoint_auto_confirms = true
}

variable "listmonk_webhook_enabled" {
  type    = bool
  default = true
}

output "smtp_host" {
  value = "email-smtp.${data.aws_region.current.region}.amazonaws.com"
}

output "config_set" {
  value = aws_sesv2_configuration_set.weekly.configuration_set_name
}

output "sns_topic_arn" {
  value = aws_sns_topic.ses_events.arn
}

output "dkim_status" {
  value = aws_sesv2_email_identity.blr_today.dkim_signing_attributes[0].status
}
