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