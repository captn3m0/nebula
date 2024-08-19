/**
 *   in.bb8.fun
 * *.in.bb8.fun
 */

resource "cloudflare_record" "home" {
  zone_id = var.zone_id
  name    = "in"
  value   = var.ips["eth0"]
  type    = "A"
}

resource "cloudflare_record" "home-wildcard" {
  zone_id = var.zone_id
  name    = "*.in"
  value   = cloudflare_record.home.hostname
  type    = "CNAME"
  ttl     = 3600
}

/**
 *    bb8.fun -> static IP address
 * *.bb8.fun  -> bb8.fun
 */
resource "cloudflare_record" "internet" {
  zone_id = var.zone_id
  name    = "@"
  value   = var.droplet_ip
  type    = "A"
}

resource "cloudflare_record" "internet-wildcard" {
  zone_id = var.zone_id
  name    = var.domain
  value   = cloudflare_record.internet.hostname
  type    = "CNAME"
  ttl     = 3600
}

resource "cloudflare_record" "dns" {
  zone_id = var.zone_id
  name    = "dns"
  value   = var.ips["static"]
  type    = "A"
}

resource "cloudflare_record" "doh" {
  zone_id = var.zone_id
  name    = "doh"
  value   = var.ips["static"]
  type    = "A"
}

// This ensures that _acme-challenge is not a CNAME
// alongside the above wildcard CNAME entry.
resource "cloudflare_record" "acme-no-cname-1" {
  zone_id = var.zone_id
  name    = "_acme-challenge.${var.domain}"
  type    = "A"
  value   = "127.0.0.1"
  ttl     = "300"
}

/**
 *   vpn.bb8.fun
 * *.vpn.bb8.fun
 */
resource "cloudflare_record" "vpn" {
  zone_id = var.zone_id
  name    = "vpn"
  value   = var.ips["ts"]
  type    = "A"
}

resource "cloudflare_record" "vpn_wildcard" {
  zone_id = var.zone_id
  name    = "*.vpn.${var.domain}"
  value   = cloudflare_record.vpn.hostname
  type    = "CNAME"
  ttl     = 3600
}

/**
 *   vpn.bb8.fun
 * *.vpn.bb8.fun
 */
resource "cloudflare_record" "dovpn" {
  zone_id = var.zone_id
  name    = "dovpn"
  value   = var.ips["dovpn"]
  type    = "A"
}

resource "cloudflare_record" "dovpn_wildcard" {
  zone_id = var.zone_id
  name    = "*.dovpn.${var.domain}"
  value   = cloudflare_record.dovpn.hostname
  type    = "CNAME"
  ttl     = 3600
}

########################
## Mailgun Mailing Lists
########################

resource "cloudflare_record" "mailgun-spf" {
  zone_id = var.zone_id
  name    = "l"
  value   = "v=spf1 include:mailgun.org ~all"
  type    = "TXT"
}

resource "cloudflare_record" "mailgun-dkim" {
  zone_id = var.zone_id
  name    = "k1._domainkey.l"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnbP+IQkuPkgmUhpqCKzIdDSZ0HazaMp+cdBH++LBed8oY8/jmV8BhxMp5JwyePzRTxneT8ASsRtcp7CQ3z4nMC7aFX0kH6Bnu2v+u2JWudxs8x0I02OrPbSaQ5QVQdbAaCUCEfCQ06LJsn8aqPNrRIOWEMnxln+ebFJ0wKGscFQIDAQAB"
  type    = "TXT"
}

resource "cloudflare_record" "mailgun-mxa" {
  zone_id  = var.zone_id
  name     = "l"
  value    = "mxa.mailgun.org"
  type     = "MX"
  priority = 10
}

resource "cloudflare_record" "mailgun-mxb" {
  zone_id  = var.zone_id
  name     = "l"
  value    = "mxb.mailgun.org"
  type     = "MX"
  priority = 20
}
