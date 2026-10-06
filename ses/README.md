# ses

Amazon SES (ap-south-1) for sending as `blr.today`, used by listmonk at
https://lists.blr.today as its SMTP backend.

- Domain identity `blr.today` with Easy DKIM (2048-bit), default config set
  `blr-today-weekly`
- Custom MAIL FROM `bounce.blr.today` (MX + SPF on Netlify DNS)
- `_dmarc.blr.today` with `p=none`
- Bounces (config set event) and complaints (identity notification, with
  original headers) go to SNS topic `ses-blr-today-events`
- Account suppression list for BOUNCE and COMPLAINT
- IAM user `ses-smtp-blr-today`, send-only on the identity and config set.
  SMTP credentials are written to pass at `blr.today/ses-smtp`
  (password + `username`, `host`, `port`, `tls`, `config_set`)

The apex SPF is not changed: SPF is checked against the envelope sender,
which is `bounce.blr.today`, and DMARC aligns on it (relaxed) and on DKIM.

## Applying

`NebulaTF` (profile `nebula`) only has access to the state bucket. The
principal applying this root needs, roughly:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {"Effect": "Allow", "Action": "ses:*", "Resource": "*"},
    {"Effect": "Allow", "Action": "sns:*",
     "Resource": "arn:aws:sns:ap-south-1:301109182511:ses-blr-today-*"},
    {"Effect": "Allow", "Action": ["iam:*User*", "iam:*AccessKey*"],
     "Resource": "arn:aws:iam::301109182511:user/ses-smtp-*"}
  ]
}
```

Use `-var aws_profile=...` to apply with another profile.

## listmonk bounce webhook

Once listmonk serves `/webhooks/service/ses` and has SES bounces enabled
(Settings -> Bounces), subscribe it to the topic; listmonk confirms the
subscription itself. Set the `listmonk_webhook_enabled` default to `true`
in `smtp.tf` and apply.
