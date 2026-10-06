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

data "pass_password" "listmonk_digest" {
  path = "blr.today/listmonk-api-digest"
}

resource "kubernetes_secret_v1" "scheduler_listmonk" {
  metadata {
    name      = "scheduler-listmonk"
    namespace = "scheduler"
  }

  data = {
    LISTMONK_API_USER    = data.pass_password.listmonk_digest.data["user"]
    LISTMONK_API_TOKEN   = trimspace(data.pass_password.listmonk_digest.password)
    LISTMONK_LIST_ID     = data.pass_password.listmonk_digest.data["list_id"]
    LISTMONK_TEMPLATE_ID = data.pass_password.listmonk_digest.data["weekly_template_id"]
  }

  type = "Opaque"
}
