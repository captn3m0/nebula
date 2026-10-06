# Bluesky handle verification for blr.today accounts on the eurosky PDS
locals {
  bluesky = {
    events      = "did:plc:kz3xdvmoztnqr2f36oxtjr7g"
    curated     = "did:plc:e47aa4am3hekue3qfws3vn74"
    indiranagar = "did:plc:thsvbapfrowczhsakvvuq7lf"
    cbd         = "did:plc:kzdb4mxxj5tqqkj26kzegabp"
    lastcall    = "did:plc:iijvidif5qnmtgik6d6q3isb"
    free        = "did:plc:4nfsbt4sxi54gjwb2y2575i2"
  }
}

data "netlify_dns_zone" "blr_today" {
  name = "blr.today"
}

resource "netlify_dns_record" "atproto" {
  for_each = local.bluesky
  type     = "TXT"
  zone_id  = data.netlify_dns_zone.blr_today.id
  hostname = "_atproto.${each.key}.blr.today"
  value    = "did=${each.value}"
}

# snac on the k3s cluster, see manifests/snac
import {
  to = netlify_dns_record.fedi
  id = "6686ae224250ed0fb5587149:669632b3296a3f512e9456b3"
}

resource "netlify_dns_record" "fedi" {
  type     = "A"
  zone_id  = data.netlify_dns_zone.blr_today.id
  hostname = "fedi.blr.today"
  value    = "139.59.48.222"
}

# The scheduler's report, proxied by the website at /_debug/social/
resource "netlify_dns_record" "scheduler" {
  type     = "A"
  zone_id  = data.netlify_dns_zone.blr_today.id
  hostname = "scheduler.blr.today"
  value    = "139.59.48.222"
}

# Bearer or basic auth password for Grafana Cloud to scrape blr.today/metrics/authenticated
data "pass_password" "metrics_token" {
  path = "blr.today/grafana-metrics"
}

resource "netlify_environment_variable" "metrics_token" {
  team_id = "5a2d2d35df99534c1cda3053"
  site_id = "22e12fee-effc-43e9-a409-2c0d2e8d7602"
  key     = "METRICS_TOKEN"
  # Secrets need scopes, which the free plan can't set
  values = [{
    value   = trimspace(data.pass_password.metrics_token.password)
    context = "all"
  }]
}
