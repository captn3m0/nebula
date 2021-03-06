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
  value  = "${var.droplet_ip}"
  type   = "A"
}

resource "cloudflare_record" "internet-wildcard" {
  domain = "${var.domain}"
  name   = "*.${var.domain}"
  value  = "${cloudflare_record.internet.hostname}"
  type   = "CNAME"
  ttl    = 3600
}

resource "cloudflare_record" "dns" {
  domain = "${var.domain}"
  name   = "dns"
  value  = "${var.ips["static"]}"
  type   = "A"
}

resource "cloudflare_record" "doh" {
  domain = "${var.domain}"
  name   = "doh"
  value  = "${var.ips["static"]}"
  type   = "A"
}

// This ensures that _acme-challenge is not a CNAME
// alongside the above wildcard CNAME entry.
resource "cloudflare_record" "acme-no-cname-1" {
  domain = "${var.domain}"
  name   = "_acme-challenge.${var.domain}"
  type   = "A"
  value  = "127.0.0.1"
  ttl    = "300"
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

/**
 *   vpn.bb8.fun
 * *.vpn.bb8.fun
 */
resource "cloudflare_record" "dovpn" {
  domain = "${var.domain}"
  name   = "dovpn"
  value  = "${var.ips["dovpn"]}"
  type   = "A"
}

resource "cloudflare_record" "dovpn_wildcard" {
  domain = "${var.domain}"
  name   = "*.dovpn.${var.domain}"
  value  = "${cloudflare_record.dovpn.hostname}"
  type   = "CNAME"
  ttl    = 3600
}

resource "cloudflare_record" "etcd" {
  domain = "${var.domain}"
  name   = "etcd"
  value  = "${var.ips["dovpn"]}"
  type   = "A"
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

resource "cloudflare_record" "k8s" {
  domain = "${var.domain}"
  name   = "k8s"
  value  = "10.8.0.1"
  type   = "A"
  ttl    = 3600
}
