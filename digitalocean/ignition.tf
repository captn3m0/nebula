data "ignition_config" "hydrogen" {
  systemd = [
      "${data.ignition_systemd_unit.hydrogen.id}",
  ]
}

data "ignition_systemd_unit" "hydrogen-docker" {
  name = "docker.service"
  content = "[Service]\nType=oneshot\nExecStart=/usr/bin/echo Hello World\n\n[Install]\nWantedBy=multi-user.target"
}
