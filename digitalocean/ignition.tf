# Based on https://github.com/jjduhamel/tf-files/blob/master/swarm/ignition.tf

data "ignition_user" "core" {
  name = "core"
  no_create_home = true
  groups = [ "wheel", "docker", "systemd-journal" ]
}

data "ignition_user" "nemo" {
  name = "nemo"
  groups = [ "wheel", "sudo", "docker", "systemd-journal" ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDy8R99Ht7DVkEPW/v9/4Rf7oijC0m6/PJPNEQO9lfB340zS55cVblensxojZjkauV51vLcGfFvBCt3S/PJfZVP5isjmjqN6A7CVHc/d9+BCTepZe6TjrS/jTF+D3LoZ8xpXr7Kgf/K5Sq05XJtXfArXHJrOGBldCRHVMR/aVheDJSa0bYFsj5OhF8cOggo5vbhymgP3VbRJ0NWXDwPu5YrRiDkt02Oli9HpsR6K6CvNXeMCSBGaK/hlsRoWKM9qhtmNvb+6brCZ5MCkfF6MA395dyM9xLiAdYxudhbCfCylX7DPAFqwdrRvgLI12xM/1zsUEq8vGMJzMFnUjGhers9 nemo@flying-nemo"
  ]
}

data "ignition_systemd_unit" "docker-tcp" {
  name = "docker-tcp.socket"
  enable = true
  content = "${ file("${ path.module }/docker-tcp.socket") }"
}

data "ignition_config" "hydrogen" {
  systemd = [
    "${ data.ignition_systemd_unit.docker-tcp.id }"
  ]

  users = [
    "${ data.ignition_user.core.id }",
    "${ data.ignition_user.nemo.id }",
  ]
}
