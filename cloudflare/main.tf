/**
 *   in.bb8.fun
 * *.in.bb8.fun
 */

resource "cloudflare_record" "home" {
  domain = "${var.domain}"
  name   = "in"
  value  = "${var.ips["eth0"]}"
  type   = "A"
}

resource "cloudflare_record" "home-wildcard" {
  domain = "${var.domain}"
  name   = "*.in"
  value  = "${cloudflare_record.home.hostname}"
  type   = "CNAME"
  ttl    = 3600
}

/**
 *    bb8.fun -> static IP address
 * *.bb8.fun  -> bb8.fun
 */
resource "cloudflare_record" "internet" {
  domain = "${var.domain}"
  name   = "@"
  value  = "${var.ips["static"]}"
  type   = "A"
}

resource "cloudflare_record" "internet-wildcard" {
  domain = "${var.domain}"
  name   = "*.${var.domain}"
  value  = "${cloudflare_record.internet.hostname}"
  type   = "CNAME"
  ttl    = 3600
}

/**
 *   vpn.bb8.fun
 * *.vpn.bb8.fun
 */
resource "cloudflare_record" "vpn" {
  domain = "${var.domain}"
  name   = "vpn"
  value  = "${var.ips["tun0"]}"
  type   = "A"
}

resource "cloudflare_record" "vpn_wildcard" {
  domain = "${var.domain}"
  name   = "*.vpn.${var.domain}"
  value  = "${cloudflare_record.vpn.hostname}"
  type   = "CNAME"
  ttl    = 3600
}

########################
## Mailgun Mailing Lists
########################

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
  domain   = "${var.domain}"
  name     = "l"
  value    = "mxa.mailgun.org"
  type     = "MX"
  priority = 10
}

resource "cloudflare_record" "mailgun-mxb" {
  domain   = "${var.domain}"
  name     = "l"
  value    = "mxb.mailgun.org"
  type     = "MX"
  priority = 20
}
