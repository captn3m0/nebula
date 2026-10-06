data "pass_password" "scheduler_bluesky" {
  path = "blr.today/bsky/github-actions-secret"
}

resource "kubernetes_secret_v1" "scheduler_bluesky" {
  metadata {
    name      = "scheduler-bluesky"
    namespace = "scheduler"
  }

  data = {
    app-passwords = data.pass_password.scheduler_bluesky.password
  }

  type = "Opaque"
}

data "pass_password" "scheduler_fedi" {
  path = "blr.today/fedi/github-actions-secret"
}

resource "kubernetes_secret_v1" "scheduler_fedi" {
  metadata {
    name      = "scheduler-fedi"
    namespace = "scheduler"
  }

  data = {
    tokens = data.pass_password.scheduler_fedi.password
  }

  type = "Opaque"
}
