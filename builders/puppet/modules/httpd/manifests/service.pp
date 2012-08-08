class httpd::service {
  service { "httpd":
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
  }
}
