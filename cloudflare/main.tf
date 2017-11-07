resource "cloudflare_record" "home-wildcard" {
  domain = "${var.domain}"
  name   = "*.in"
  value  = "192.168.1.111"
  type   = "A"
  ttl    = 300
}

resource "cloudflare_record" "home" {
  domain = "${var.domain}"
  name   = "in"
  value  = "192.168.1.111"
  type   = "A"
}

resource "cloudflare_record" "internet" {
  domain = "${var.domain}"
  name   = "@"
  value  = "${var.proxy}"
  type   = "CNAME"
}

resource "cloudflare_record" "internet-wildcard" {
  domain = "${var.domain}"
  name   = "*.bb8.fun"
  value  = "${var.proxy}"
  type   = "CNAME"
}

resource "cloudflare_record" "act" {
  domain = "${var.domain}"
  name   = "act"
  value  = "${var.act_ip}"
  type   = "A"
}

resource "cloudflare_record" "act-wildcard" {
  domain = "${var.domain}"
  name   = "*.act"
  value  = "${var.act_ip}"
  type   = "A"
}

resource "cloudflare_record" "mailgun-spf" {
  domain = "${var.domain}"
  name   = "l"
  value  = "v=spf1 include:mailgun.org ~all"
  type   = "TXT"
}

resource "cloudflare_record" "mailgun-dkim" {
  domain = "${var.domain}"
  name   = "k1._domainkey.l"
  value  = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnbP+IQkuPkgmUhpqCKzIdDSZ0HazaMp+cdBH++LBed8oY8/jmV8BhxMp5JwyePzRTxneT8ASsRtcp7CQ3z4nMC7aFX0kH6Bnu2v+u2JWudxs8x0I02OrPbSaQ5QVQdbAaCUCEfCQ06LJsn8aqPNrRIOWEMnxln+ebFJ0wKGscFQIDAQAB"
  type   = "TXT"
}

resource "cloudflare_record" "mailgun-mxa" {
  domain = "${var.domain}"
  name   = "l"
  value  = "mxa.mailgun.org"
  type   = "MX"
  priority = 10
}

resource "cloudflare_record" "mailgun-mxb" {
  domain = "${var.domain}"
  name   = "l"
  value  = "mxb.mailgun.org"
  type   = "MX"
  priority = 20
}