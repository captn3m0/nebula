# # This is pending on https://github.com/hashicorp/go-version/pull/34

# Create a Database
resource "mysql_database" "lychee" {
  name = "lychee"

  lifecycle {
    prevent_destroy = true
  }
}

resource "mysql_user" "lychee" {
  user               = "lychee"
  host               = "${var.lychee_ip}"
  plaintext_password = "${var.mysql_lychee_password}"
}

resource "mysql_grant" "lychee" {
  user       = "${mysql_user.lychee.user}"
  host       = "${mysql_user.lychee.host}"
  database   = "${mysql_database.lychee.name}"
  privileges = ["ALL"]
}
