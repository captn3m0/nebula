data "pass_password" "listmonk_db" {
  path = "Nebula/listmonk-db-postgres-supabase"
}

resource "kubernetes_secret_v1" "listmonk_db" {
  metadata {
    name      = "listmonk-db"
    namespace = "listmonk"
  }
  data = {
    password = trimspace(data.pass_password.listmonk_db.password)
  }
  type = "Opaque"
}

resource "random_password" "listmonk_admin" {
  length  = 32
  special = false
}

resource "pass_password" "listmonk_admin" {
  path     = "Nebula/listmonk-admin"
  password = random_password.listmonk_admin.result
  data     = { username = "admin", url = "https://lists.blr.today/admin" }
}

resource "kubernetes_secret_v1" "listmonk_admin" {
  metadata {
    name      = "listmonk-admin"
    namespace = "listmonk"
  }
  data = {
    username = "admin"
    password = random_password.listmonk_admin.result
  }
  type = "Opaque"
}
