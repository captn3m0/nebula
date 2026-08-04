resource "null_resource" "k3s_install" {
  triggers = {
    k3s_version = var.k3s_version
  }

  connection {
    type  = "ssh"
    host  = var.tailscale_ip
    user  = "root"
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=\"${var.k3s_version}\" INSTALL_K3S_EXEC=\"--disable servicelb --tls-san ${var.tailscale_ip} --tls-san ${digitalocean_floating_ip.ceylon.ip_address}\" sh -",
    ]
  }

  provisioner "local-exec" {
    command = <<-EOT
      scp -o StrictHostKeyChecking=accept-new root@${var.tailscale_ip}:/etc/rancher/k3s/k3s.yaml ${path.module}/kubeconfig
      sed -i.bak 's/127.0.0.1/${var.tailscale_ip}/' ${path.module}/kubeconfig
      rm -f ${path.module}/kubeconfig.bak
    EOT
  }
}

output "k3s_api_server" {
  value = "https://${var.tailscale_ip}:6443"
}

output "k3s_api_server_public" {
  value = "https://${digitalocean_floating_ip.ceylon.ip_address}:6443"
}

output "k3s_kubeconfig_path" {
  value = "${path.module}/kubeconfig"
}
