data "template_file" "wiki-config" {
  template = file("docker/conf/wiki.tpl")
  vars = {
    DB_PASSWORD = data.pass_password.wiki-db-password.password
  }
}

resource "local_file" "wiki-config" {
  content  = data.template_file.wiki-config.rendered
  filename = "docker/conf/wiki.yml"
}

module "wiki-container" {
  name   = "wiki2"
  source = "./modules/container"
  image  = "requarks/wiki:2"

  resource = {
    memory      = 1024
    memory_swap = 1024
  }

  web = {
    expose = true
    port   = 3000
    host   = "wiki.bb8.fun"
  }

  networks_advanced = [
    {
      name = "traefik"
    },
    {
      name = "postgres"
    },
    {
      name = "external"
    },
  ]

  uploads = [
    {
      content = file("docker/conf/wiki.yml")
      file    = "/wiki/config.yml"
    },
  ]

  volumes = [
    {
      host_path      = "/mnt/xwing/data/wiki/data"
      container_path = "/data"
    },
    {
      host_path      = "/mnt/xwing/data/wiki/databackup"
      container_path = "/old/data"
    },
    {
      host_path      = "/mnt/xwing/data/wiki/repo"
      container_path = "/old/repo"
    },
  ]
}

module "wiki-db" {
  source   = "./modules/postgres"
  name     = "wikijs"
  password = data.pass_password.wiki-db-password.password
}

