consul {
  address = "consul:8500"

  retry {
    enabled  = true
    attempts = 12
    backoff  = "250ms"
  }
}

template {
  source      = "/etc/targets.ctmpl"
  destination = "/var/www/targets.txt"
  perms       = 0644
}
