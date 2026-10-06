# Verified test recipients, so mail reaches them while SES is in the sandbox; SES emails each a link to click
resource "aws_sesv2_email_identity" "test_recipient" {
  for_each       = toset(["wildcard@captnemo.in", "weekly-always@captnemo.in", "weekly-never@captnemo.in"])
  email_identity = each.value
}
