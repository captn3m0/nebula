/**
 *   in.bb8.fun
 * *.in.bb8.fun
 */

resource "cloudflare_record" "home" {
  zone_id = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name    = "in"
  content = var.ips["eth0"]
  type    = "A"
}

resource "cloudflare_record" "home-wildcard" {
  zone_id = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name    = "*.in"
  content = cloudflare_record.home.hostname
  type    = "CNAME"
  ttl     = 3600
}

/**
 *    bb8.fun -> static IP address
 * *.bb8.fun  -> bb8.fun
 */
resource "cloudflare_record" "internet" {
  zone_id = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name    = var.domain
  content = var.ips["static"]
  type    = "A"
}

resource "cloudflare_record" "internet-wildcard" {
  zone_id = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name    = "*"
  content = cloudflare_record.internet.hostname
  type    = "CNAME"
  ttl     = 3600
}

resource "cloudflare_record" "dns" {
  zone_id = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name    = "dns"
  content = var.ips["static"]
  type    = "A"
}


########################
## Mailgun Mailing Lists
########################

resource "cloudflare_record" "mailgun-spf" {
  zone_id = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name    = "l"
  content = "v=spf1 include:mailgun.org ~all"
  type    = "TXT"
}

resource "cloudflare_record" "mailgun-dkim" {
  zone_id = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name    = "k1._domainkey.l"
  content = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnbP+IQkuPkgmUhpqCKzIdDSZ0HazaMp+cdBH++LBed8oY8/jmV8BhxMp5JwyePzRTxneT8ASsRtcp7CQ3z4nMC7aFX0kH6Bnu2v+u2JWudxs8x0I02OrPbSaQ5QVQdbAaCUCEfCQ06LJsn8aqPNrRIOWEMnxln+ebFJ0wKGscFQIDAQAB"
  type    = "TXT"
}

resource "cloudflare_record" "mailgun-mxa" {
  zone_id  = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name     = "l"
  content  = "mxa.mailgun.org"
  type     = "MX"
  priority = 10
}

resource "cloudflare_record" "mailgun-mxb" {
  zone_id  = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  name     = "l"
  content  = "mxb.mailgun.org"
  type     = "MX"
  priority = 20
}
