data "docker_network" "bridge" {
  name = "bridge"
}

data "cloudflare_zones" "bb8" {
  filter {
    name        = "bb8"
    lookup_type = "exact"
    match       = "bb8.fun"
  }
}
