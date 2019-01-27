resource "docker_container" "bootkube" {
  image = "${docker_image.image.latest}"
  name  = "bootkube"

  volumes {
    container_path = "/etc/kubernetes"
    host_path      = "/etc/kubernetes"
  }

  # bootstrap manifests

  upload {
    content = "${file("${var.asset-dir}/bootstrap-manifests/bootstrap-apiserver.yaml")}"
    file    = "/home/.bootkube/bootstrap-manifests/bootstrap-apiserver.yaml"
  }
  upload {
    content = "${file("${var.asset-dir}/bootstrap-manifests/bootstrap-controller-manager.yaml")}"
    file    = "/home/.bootkube/bootstrap-manifests/bootstrap-controller-manager.yaml"
  }
  upload {
    content = "${file("${var.asset-dir}/bootstrap-manifests/bootstrap-scheduler.yaml")}"
    file    = "/home/.bootkube/bootstrap-manifests/bootstrap-scheduler.yaml"
  }
  # etcd secrets
  #
  upload {
    file    = "/home/.bootkube/tls/etcd-client-ca.crt"
    content = "${file("${var.asset-dir}/tls/etcd-client-ca.crt")}"
  }
  upload {
    file    = "/home/.bootkube/tls/etcd-client.crt"
    content = "${file("${var.asset-dir}/tls/etcd-client.crt")}"
  }
  upload {
    file    = "/home/.bootkube/tls/etcd-client.key"
    content = "${file("${var.asset-dir}/tls/etcd-client.key")}"
  }
  # Cluster Networking
  upload {
    content = "${file("${var.asset-dir}/manifests-networking/cluster-role-binding.yaml")}"
    file    = "/home/.bootkube/manifests-networking/cluster-role-binding.yaml"
  }
  upload {
    content = "${file("${var.asset-dir}/manifests-networking/cluster-role.yaml")}"
    file    = "/home/.bootkube/manifests-networking/cluster-role.yaml"
  }
  upload {
    content = "${file("${var.asset-dir}/manifests-networking/config.yaml")}"
    file    = "/home/.bootkube/manifests-networking/config.yaml"
  }
  upload {
    content = "${file("${var.asset-dir}/manifests-networking/daemonset.yaml")}"
    file    = "/home/.bootkube/manifests-networking/daemonset.yaml"
  }
  upload {
    content = "${file("${var.asset-dir}/manifests-networking/service-account.yaml")}"
    file    = "/home/.bootkube/manifests-networking/service-account.yaml"
  }
  # TLS
  upload {
    file    = "/home/.bootkube/tls/service-account.pub"
    content = "${file("${var.asset-dir}/tls/service-account.pub")}"
  }
  upload {
    content = "${file("${var.asset-dir}/tls/ca.key")}"
    file    = "/home/.bootkube/tls/ca.key"
  }
  upload {
    content = "${file("${var.asset-dir}/tls/ca.crt")}"
    file    = "/home/.bootkube/tls/ca.crt"
  }
  upload {
    content = "${file("${var.asset-dir}/tls/apiserver.key")}"
    file    = "/home/.bootkube/tls/apiserver.key"
  }
  upload {
    content = "${file("${var.asset-dir}/tls/apiserver.crt")}"
    file    = "/home/.bootkube/tls/apiserver.crt"
  }
  upload {
    content = "${var.assets["kubelet_cert"]}"
    file    = "/home/.bootkube/tls/kubelet.crt"
  }
  upload {
    content = "${var.assets["kubelet_key"]}"
    file    = "/home/.bootkube/tls/kubelet.key"
  }
  # TODO: Generate Filenames Dynamically
  # TODO: Check if this is needed at all
  upload {
    content = "${file("${var.asset-dir}/auth/k8s.bb8.fun-config")}"
    file    = "/home/.bootkube/auth/k8s.bb8.fun-config"
  }
  # auth/kubeconfig-kubelet
  upload {
    content = "${var.assets["kubeconfig-kubelet"]}"
    file    = "/home/.bootkube/auth/kubeconfig-kubelet"
  }
  # TODO: Move to a module read instead of file
  # auth/kubeconfig
  upload {
    file    = "/home/.bootkube/auth/kubeconfig"
    content = "${file("${var.asset-dir}/auth/kubeconfig")}"
  }
  # Manifests Directory
  upload {
    file    = "/home/.bootkube/manifests/kube-apiserver-role-binding.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-apiserver-role-binding.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-apiserver-sa.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-apiserver-sa.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-apiserver-secret.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-apiserver-secret.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-apiserver.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-apiserver.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kubeconfig-in-cluster.yaml"
    content = "${file("${var.asset-dir}/manifests/kubeconfig-in-cluster.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-controller-manager-disruption.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-controller-manager-disruption.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-controller-manager-role-binding.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-controller-manager-role-binding.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-controller-manager-sa.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-controller-manager-sa.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-controller-manager-secret.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-controller-manager-secret.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-controller-manager.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-controller-manager.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kubelet-nodes-cluster-role-binding.yaml"
    content = "${file("${var.asset-dir}/manifests/kubelet-nodes-cluster-role-binding.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-proxy-role-binding.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-proxy-role-binding.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-proxy-sa.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-proxy-sa.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-proxy.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-proxy.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-scheduler-disruption.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-scheduler-disruption.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-scheduler-role-binding.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-scheduler-role-binding.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-scheduler-sa.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-scheduler-sa.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-scheduler-volume-scheduler-role-binding.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-scheduler-volume-scheduler-role-binding.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/kube-scheduler.yaml"
    content = "${file("${var.asset-dir}/manifests/kube-scheduler.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/pod-checkpointer-cluster-role-binding.yaml"
    content = "${file("${var.asset-dir}/manifests/pod-checkpointer-cluster-role-binding.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/pod-checkpointer-cluster-role.yaml"
    content = "${file("${var.asset-dir}/manifests/pod-checkpointer-cluster-role.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/pod-checkpointer-role-binding.yaml"
    content = "${file("${var.asset-dir}/manifests/pod-checkpointer-role-binding.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/pod-checkpointer-role.yaml"
    content = "${file("${var.asset-dir}/manifests/pod-checkpointer-role.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/pod-checkpointer-sa.yaml"
    content = "${file("${var.asset-dir}/manifests/pod-checkpointer-sa.yaml")}"
  }
  upload {
    file    = "/home/.bootkube/manifests/pod-checkpointer.yaml"
    content = "${file("${var.asset-dir}/manifests/pod-checkpointer.yaml")}"
  }
  command = [
    "/bootkube",
    "start",
    "--asset-dir=/home/.bootkube",
  ]
  network_mode    = "host"
  restart         = "on-failure"
  max_retry_count = 5
}

data "docker_registry_image" "image" {
  name = "quay.io/coreos/bootkube:v${var.version}"
}

resource "docker_image" "image" {
  name          = "${data.docker_registry_image.image.name}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
}
