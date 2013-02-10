define stingray::virtualserver::addvirtualserver (
  $virtual_server_name = $title,
  $port                = 80,
  $protocol            = "http",
  $default_pool,
) {
  stingray::exec { "create virtual server $virtual_server_name" :
    command => "VirtualServer.addVirtualServer \"$virtual_server_name\" { port: $port, protocol: $protocol, default_pool: \"$default_pool\" }"
  }
}
