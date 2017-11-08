resource "docker_volume" "mariadb_volume" {
  name = "mariadb_volume"
}

resource "docker_volume" "gitea_volume" {
  name = "gitea_volume"
}