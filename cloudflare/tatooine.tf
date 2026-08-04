# The tatooine.club apex is a Netlify-hosted site (CNAME to
# apex-loadbalancer.netlify.com) and mail runs on Migadu - neither is ours to
# touch. XMPP identity stays on the bare domain (nemo@tatooine.club) via SRV
# records that point connections at a dedicated host record instead of the
# apex, matching how the existing Migadu SRV records (_imaps, _pop3s, etc.)
# already coexist with the apex CNAME.

resource "cloudflare_record" "ceylon_tatooine" {
  provider = cloudflare.global
  zone_id  = lookup(data.cloudflare_zones.tatooine.zones[0], "id")
  name     = "ceylon"
  content  = var.ips["static"]
  type     = "A"
}

resource "cloudflare_record" "srv_xmpp_client_tatooine" {
  provider = cloudflare.global
  zone_id  = lookup(data.cloudflare_zones.tatooine.zones[0], "id")
  name     = "_xmpp-client._tcp"
  type     = "SRV"

  data {
    service  = "_xmpp-client"
    proto    = "_tcp"
    name     = "@"
    priority = 0
    weight   = 0
    port     = 5222
    target   = cloudflare_record.ceylon_tatooine.hostname
  }
}

resource "cloudflare_record" "srv_xmpp_server_tatooine" {
  provider = cloudflare.global
  zone_id  = lookup(data.cloudflare_zones.tatooine.zones[0], "id")
  name     = "_xmpp-server._tcp"
  type     = "SRV"

  data {
    service  = "_xmpp-server"
    proto    = "_tcp"
    name     = "@"
    priority = 0
    weight   = 0
    port     = 5269
    target   = cloudflare_record.ceylon_tatooine.hostname
  }
}

# Component subdomains don't strictly need their own DNS entry for XMPP
# stanza routing (the server routes to them internally over the one
# connection already established to tatooine.club), but some clients do a
# naive "does this domain resolve" check on manually-entered JIDs. signal/
# upload stay unresolvable for now since those gateways aren't enabled.
resource "cloudflare_record" "muc_tatooine" {
  provider = cloudflare.global
  zone_id  = lookup(data.cloudflare_zones.tatooine.zones[0], "id")
  name     = "521ab"
  content  = cloudflare_record.ceylon_tatooine.hostname
  type     = "CNAME"
}

resource "cloudflare_record" "telegram_tatooine" {
  provider = cloudflare.global
  zone_id  = lookup(data.cloudflare_zones.tatooine.zones[0], "id")
  name     = "telegram"
  content  = cloudflare_record.ceylon_tatooine.hostname
  type     = "CNAME"
}
