resource "docker_volume" "mariadb_volume" {
  name = "mariadb_volume"
}

resource "docker_volume" "postgres_volume" {
  name = "postgres_volume"
}

resource "docker_volume" "mongorocks_data_volume" {
  name = "mongorocks_data_volume"
}