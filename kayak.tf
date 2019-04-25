# // Points to the local working directory instead of
# // the published version
# module "kayak" {
#   source    = "../terraform-digitalocean-kayak"
#   cert_path = "${path.root}/secrets/kayak"
#   domain    = "kayak.${var.root-domain}"
#   ssh_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD0Getey8585AqdgIl9mqQ3SH9w6z7NZUW4HXdOqZwC7sYEaDrLOBV014gtFS8h8ymm4dcw6xEGUkaavcHC8W9ChTLKBMK4N1/sUS/umLy+Wi/K//g13y0VHSdvcc+gMQ27b9n/DwDY4ZKkaf6t+4HWyFWNh6gp0cT1WCyLNlsER55KUdy+C1lCOpv1SMepOaYc7uyBlC9FfgewJho/OfxnoTztQV6QeSGfr2Xr94Ip1FUPoLoBLLilh4ZbCe6F6bqn0kNgVBTkrVwWJv5Z0jCJpUjER69cqjASRao9KCHkyPtybzKKhCLZIlB3QMggEv0xnlHMpeeuDWcGrBVPKI8V"
#   asset_dir = "${path.root}/k8s"
#   providers {
#     docker = "docker.kayak"
#   }
# }
provider "docker" {
  host          = "tcp://${cloudflare_record.kayak-docker.hostname}:2376"
  version       = "~> 2.0.0"
  alias         = "kayak"
  ca_material   = "${module.kayak.docker_ca_cert}"
  cert_material = "${module.kayak.docker_client_cert}"
  key_material  = "${module.kayak.docker_client_key}"
}

# resource "cloudflare_record" "kayak-docker" {
#   name   = "docker.kayak"
#   value  = "${module.kayak.droplet_ipv4}"
#   domain = "${var.root-domain}"
#   type   = "A"
#   ttl    = 120
# }
# resource "cloudflare_record" "kayak" {
#   name   = "kayak"
#   value  = "${module.kayak.droplet_ipv4}"
#   domain = "${var.root-domain}"
#   type   = "A"
#   ttl    = 120
# }
# resource "cloudflare_record" "kayak-etcd" {
#   name   = "etcd.kayak"
#   value  = "${module.kayak.droplet_ipv4_private}"
#   domain = "${var.root-domain}"
#   type   = "A"
#   ttl    = 120
# }

