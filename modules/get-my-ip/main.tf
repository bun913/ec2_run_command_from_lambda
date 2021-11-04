data http ifconfig {
  url = "http://ipv4.icanhazip.com/"
}

locals {
  current-ip = chomp(data.http.ifconfig.body)
}
