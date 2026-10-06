locals {
  domain     = "blr.today"
  mail_from  = "bounce.blr.today"
  config_set = "blr-today-weekly"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_sesv2_account_suppression_attributes" "this" {
  suppressed_reasons = ["BOUNCE", "COMPLAINT"]
}

resource "aws_sesv2_configuration_set" "weekly" {
  configuration_set_name = local.config_set

  reputation_options {
    reputation_metrics_enabled = true
  }

  sending_options {
    sending_enabled = true
  }

  suppression_options {
    suppressed_reasons = ["BOUNCE", "COMPLAINT"]
  }
}

resource "aws_sesv2_email_identity" "blr_today" {
  email_identity         = local.domain
  configuration_set_name = aws_sesv2_configuration_set.weekly.configuration_set_name

  dkim_signing_attributes {
    next_signing_key_length = "RSA_2048_BIT"
  }
}

resource "aws_sesv2_email_identity_mail_from_attributes" "blr_today" {
  email_identity         = aws_sesv2_email_identity.blr_today.email_identity
  behavior_on_mx_failure = "USE_DEFAULT_VALUE"
  mail_from_domain       = local.mail_from
}

resource "aws_sns_topic" "ses_events" {
  name = "ses-blr-today-events"
}

data "aws_iam_policy_document" "ses_events" {
  statement {
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.ses_events.arn]
    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

resource "aws_sns_topic_policy" "ses_events" {
  arn    = aws_sns_topic.ses_events.arn
  policy = data.aws_iam_policy_document.ses_events.json
}

resource "aws_sesv2_configuration_set_event_destination" "bounces" {
  configuration_set_name = aws_sesv2_configuration_set.weekly.configuration_set_name
  event_destination_name = "listmonk-bounces"

  event_destination {
    enabled              = true
    matching_event_types = ["BOUNCE"]
    sns_destination {
      topic_arn = aws_sns_topic.ses_events.arn
    }
  }

  depends_on = [aws_sns_topic_policy.ses_events]
}

# listmonk drops eventType=Complaint, so complaints come as identity notifications
resource "aws_ses_identity_notification_topic" "complaints" {
  topic_arn                = aws_sns_topic.ses_events.arn
  notification_type        = "Complaint"
  identity                 = aws_sesv2_email_identity.blr_today.email_identity
  include_original_headers = true

  depends_on = [aws_sns_topic_policy.ses_events]
}
