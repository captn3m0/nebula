// This is primarily based on https://github.com/coreos/coreos-overlay/blob/master/app-admin/kubelet-wrapper/files/kubelet-wrapper
resource "docker_container" "kubelet" {
  image = "${docker_image.image.latest}"
  name  = "kubelet-static"

  volumes {
    container_path = "/etc/kubernetes"
    host_path      = "/etc/kubernetes"
  }

  volumes {
    container_path = "/etc/kubernetes/kubeconfig"
    host_path      = "/etc/kube-assets/auth/kubeconfig-kubelet"
  }

  volumes {
    container_path = "/etc/kubernetes/kubeconfig-admin"
    host_path      = "/etc/kube-assets/auth/kubeconfig"
  }

  volumes {
    container_path = "/etc/kubernetes/ca.crt"
    host_path      = "/etc/kube-assets/tls/ca.crt"
  }

  volumes {
    container_path = "/etc/ssl/certs"
    host_path      = "/etc/ssl/certs"
    read_only      = true
  }

  volumes {
    container_path = "/usr/share/ca-certificates"
    host_path      = "/usr/share/ca-certificates"
    read_only      = true
  }

  volumes {
    container_path = "/var/lib/docker"
    host_path      = "/var/lib/docker"
  }

  volumes {
    container_path = "/var/lib/kubelet"
    host_path      = "/var/lib/kubelet"
  }

  volumes {
    container_path = "/var/log"
    host_path      = "/var/log"
  }

  volumes {
    container_path = "/run"
    host_path      = "/run"
  }

  volumes {
    container_path = "/lib/modules"
    host_path      = "/lib/modules"
    read_only      = true
  }

  volumes {
    container_path = "/etc/os-release"
    host_path      = "/usr/lib/os-release"
    read_only      = true
  }

  volumes {
    container_path = "/etc/machine-id"
    host_path      = "/etc/machine-id"
    read_only      = true
  }

  // Deviates from kubelet-wrapper

  volumes {
    container_path = "/var/lib/cni"
    host_path      = "/var/lib/cni"
  }
  command = [
    "kubelet",
    "--allow-privileged",
    "--anonymous-auth=false",
    "--authentication-token-webhook",
    "--authorization-mode=Webhook",
    "--cert-dir=/var/lib/kubelet/pki",
    "--client-ca-file=/etc/kubernetes/ca.crt",
    "--cluster_dns=${var.dns_ip}",
    "--exit-on-lock-contention=true",
    "--hostname-override=${var.host_ip}",
    "--kubeconfig=/etc/kubernetes/kubeconfig",
    "--lock-file=/var/run/lock/kubelet.lock",
    "--minimum-container-ttl-duration=10m0s",
    "--network-plugin=cni",
    "--node-labels=node-role.kubernetes.io/master",
    "--pod-manifest-path=/etc/kubernetes/manifests",
    "--read-only-port=0",
    "--rotate-certificates",
    "--cluster_domain=${var.k8s_host}",
  ]
  host {
    host = "kubernetes.default"
    ip   = "${var.host_ip}"
  }
  host {
    host = "${var.k8s_host}"
    ip   = "${var.host_ip}"
  }

  # TODO
  # "--register-with-taints=${var.node_taints}",
  # "--node-labels=${var.node_label}",

  network_mode = "host"
  privileged   = true
  restart      = "no"
  must_run     = false

  # max_retry_count = 1
}

data "docker_registry_image" "image" {
  name = "gcr.io/google_containers/hyperkube:v${var.version}"
}

resource "docker_image" "image" {
  name          = "${data.docker_registry_image.image.name}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
}
