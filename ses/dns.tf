data "netlify_dns_zone" "blr_today" {
  name = local.domain
}

resource "netlify_dns_record" "dkim" {
  count    = 3
  type     = "CNAME"
  zone_id  = data.netlify_dns_zone.blr_today.id
  hostname = "${aws_sesv2_email_identity.blr_today.dkim_signing_attributes[0].tokens[count.index]}._domainkey.${local.domain}"
  value    = "${aws_sesv2_email_identity.blr_today.dkim_signing_attributes[0].tokens[count.index]}.dkim.amazonses.com"
}

resource "netlify_dns_record" "mail_from_mx" {
  type     = "MX"
  zone_id  = data.netlify_dns_zone.blr_today.id
  hostname = local.mail_from
  value    = "feedback-smtp.${data.aws_region.current.region}.amazonses.com"
  priority = 10
}

resource "netlify_dns_record" "mail_from_spf" {
  type     = "TXT"
  zone_id  = data.netlify_dns_zone.blr_today.id
  hostname = local.mail_from
  value    = "v=spf1 include:amazonses.com ~all"
}

resource "netlify_dns_record" "dmarc" {
  type     = "TXT"
  zone_id  = data.netlify_dns_zone.blr_today.id
  hostname = "_dmarc.${local.domain}"
  value    = "v=DMARC1; p=none"
}
