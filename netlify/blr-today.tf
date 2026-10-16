# Bluesky handle verification for blr.today accounts on the eurosky PDS
locals {
  bluesky = {
    events      = "did:plc:kz3xdvmoztnqr2f36oxtjr7g"
    curated     = "did:plc:e47aa4am3hekue3qfws3vn74"
    indiranagar = "did:plc:thsvbapfrowczhsakvvuq7lf"
    cbd         = "did:plc:kzdb4mxxj5tqqkj26kzegabp"
    lastcall    = "did:plc:iijvidif5qnmtgik6d6q3isb"
    free        = "did:plc:4nfsbt4sxi54gjwb2y2575i2"
    # N=01, blrtoday001.mu.social at signup
    whitefield = "did:plc:ujhm7oadknt6spazocqyujlk"
    # N=02, blrtoday002.mu.social at signup
    koramangala = "did:plc:5arwd74hvff6ol3zzokfwkrh"
    # N=03, blrtoday003.mu.social at signup
    fitness = "did:plc:ugttxidxhyuq7whz45fhg3gp"
    # N=04, blrtoday004.mu.social at signup
    budget = "did:plc:f6dj2riqt2xwvnjrs3mmzpqv"
    # N=05, blrtoday005.mu.social at signup
    workshops = "did:plc:aykhhusswl7dup7tsblrzl37"
    # N=06, blrtoday006.mu.social at signup
    crafts = "did:plc:kzfoqnrutas4lwxxhfgsocmt"
    # N=07, blrtoday007.mu.social at signup
    food = "did:plc:rbca3h53joq54m7d24vy7l2p"
    # N=08, blrtoday008.mu.social at signup
    sports = "did:plc:25h3b5pjoognrq4c3dto2tcq"
    # N=09, blrtoday009.mu.social at signup
    afbangalore = "did:plc:htn3q6q5xmyzru2mz3bf3zqk"
    # N=10, blrtoday010.mu.social at signup
    stage = "did:plc:kxsa3xeufsdkh3dbmywrufpy"
    # N=11, blrtoday011.mu.social at signup
    comedy = "did:plc:ap5re7xevrpaemmzqoqcrph7"
    # N=12, blrtoday012.mu.social at signup
    boardgames = "did:plc:jadxy6tp6unxywyoyqqixuee"
    # N=13, blrtoday013.mu.social at signup
    music = "did:plc:wc74auyboladugg272u5gf4y"
    # N=14, blrtoday014.mu.social at signup
    hsr = "did:plc:mt62wvqlqz2uxwzaxayceyvh"
    # N=15, blrtoday015.mu.social at signup
    jpnagar = "did:plc:hdfimnkjqjevwiysvn6y4ajg"
    # N=16, blrtoday016.mu.social at signup
    north = "did:plc:mo2smfidkx7kbrm73cgt5lhd"
    # N=17, blrtoday017.mu.social at signup
    books = "did:plc:ntpw6m5e5qu4rbrjjvi7ygly"
    # N=18, blrtoday018.mu.social at signup
    dance = "did:plc:46ztsc4ei2cayhjdrriz57wp"
    # N=19, blrtoday019.mu.social at signup
    outdoors = "did:plc:nqvd2h2w3oyivwej3e76tozu"
    # N=20, blrtoday020.mu.social at signup
    underline = "did:plc:dxlf7ct737bitynzngwhs67s"
    # N=21, blrtoday021.mu.social at signup
    film = "did:plc:5zlhxtkvkicgqq3oodmd3z3b"
    # N=22, blrtoday022.mu.social at signup
    kids = "did:plc:tsomhqdqvkgzg73hdqn4whtn"
    # N=23, blrtoday023.mu.social at signup
    couples = "did:plc:z4je4xymcqdn45ts5iymu2by"
    # N=24, blrtoday024.mu.social at signup
    scigallery = "did:plc:bd3aocdhczmi735b6qobuhre"
    # N=25, blrtoday025.mu.social at signup
    rangashankara = "did:plc:uwnvkpiibu44r6l5oohlrzf3"
    # N=26, blrtoday026.mu.social at signup
    jayanagar = "did:plc:zskcljwldvefklxblplajtip"
    # N=27, blrtoday027.mu.social at signup
    bic = "did:plc:5qvieg6say27grhhz7pxy6yx"
    # N=28, blrtoday028.mu.social at signup
    quizzing = "did:plc:epxgauwfjbe7lpoe33x4vgok"
    # N=29, blrtoday029.mu.social at signup
    sabha = "did:plc:b3v6an7a4k3ndda6h7mmcxis"
    # N=30, blrtoday030.mu.social at signup
    fillum = "did:plc:ohy3fmqt5ip7mnlcgjd32dmh"
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
