# Bluesky handle verification for blr.today accounts on the eurosky PDS
locals {
  bluesky = {
    events      = "did:plc:kz3xdvmoztnqr2f36oxtjr7g"
    curated     = "did:plc:e47aa4am3hekue3qfws3vn74"
    indiranagar = "did:plc:thsvbapfrowczhsakvvuq7lf"
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
