data "cloudflare_zones" "bb8" {
  filter {
    name        = "bb8.fun"
    lookup_type = "exact"
  }
}

data "cloudflare_zones" "tatooine" {
  provider = cloudflare.global

  filter {
    name        = "tatooine.club"
    lookup_type = "exact"
  }
}
