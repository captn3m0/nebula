module "rss-bridge" {
  name   = "rss-bridge"
  source = "modules/container"
  image  = "rssbridge/rss-bridge:latest"

  web {
    expose = true
    host   = "rss-bridge.${var.root-domain}"
  }

  networks = "${list(module.docker.traefik-network-id)}"

  uploads = [{
    content = <<EOF
AmazonBridge
BandcampBridge
ContainerLinuxReleasesBridge
DiscogsBridge
FDroidBridge
FacebookBridge
GithubIssueBridge
GithubSearchBridge
GoComicsBridge
GoogleSearchBridge
InstagramBridge
ReadComicsBridge
SoundcloudBridge
SteamBridge
StripeAPIChangeLogBridge
AmazonPriceTrackerBridge
EOF

    file = "/app/public/whitelist.txt"
  }]
}
