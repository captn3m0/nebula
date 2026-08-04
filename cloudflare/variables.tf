variable "domain" {
  type    = string
  default = "bb8.fun"
}

variable "ips" {
  type = map(string)

  default = {
    eth0   = "192.168.1.111"
    ts     = "100.107.166.2"
    static = "139.59.48.222"
    ceylon = "10.139.144.88"
    dovpn  = "100.105.210.25"
  }
}
