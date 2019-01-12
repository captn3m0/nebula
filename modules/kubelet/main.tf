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
    "--kubeconfig=/etc/kubernetes/kubeconfig",
    "--client-ca-file=/etc/kubernetes/ca.crt",
    "--anonymous-auth=false",
    "--cni-conf-dir=/etc/kubernetes/cni/net.d",
    "--network-plugin=cni",
    "--lock-file=/var/run/lock/kubelet.lock",
    "--exit-on-lock-contention",
    "--pod-manifest-path=/etc/kubernetes/manifests",
    "--allow-privileged",
    "--minimum-container-ttl-duration=10m0s",
    "--cluster_dns=10.25.0.10",
    "--cluster_domain=k8s.bb8.fun",
  ]

  # TODO
  # "--register-with-taints=${var.node_taints}",
  # "--node-labels=${var.node_label}",

  network_mode    = "host"
  privileged      = true
  restart         = "no"
  must_run        = false
  max_retry_count = 1
}

data "docker_registry_image" "image" {
  name = "gcr.io/google_containers/hyperkube:v${var.version}"
}

resource "docker_image" "image" {
  name          = "${data.docker_registry_image.image.name}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
}
