module "ct-monitor" {
  name   = "./ct-monitor"
  source = "./modules/container"
  image  = "quay.io/hsn723/ct-monitor:latest"

  uploads = [
    {
      file    = "/etc/ct-monitor/config.toml"
      content = <<EOT

domains = ["captnemo.in"]
[alert_config]
  from = "ct@captnemo.in"
  recipient = "tech_cert_issuance-aaaadd3wxkjxcxtzldfsdwnzv4@razorpay.slack.com"
  mailer_config = "smtp"

[smtp]
password = "ohPied4ooh"
server = "smtp.migadu.com"
port = 465

[position_config]
    filename = "/var/log/ct-monitor/positions.toml"
EOT

    },
  ]
}

