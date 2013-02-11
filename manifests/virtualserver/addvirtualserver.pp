define stingray::virtualserver::addvirtualserver (
  $virtual_server_name = $title,
  $port                = 80,
  $protocol            = "http",
  $default_pool,
) {
  # Create the server
  stingray::exec { "create virtual server $virtual_server_name" :
    command => "VirtualServer.addVirtualServer \"$virtual_server_name\" { port: $port, protocol: $protocol, default_pool: \"$default_pool\" }"
  }

  # And enable it
  stingray::exec { "enable virtual server $virtual_server_name" :
    command => "VirtualServer.setEnabled [\"$virtual_server_name\"] [true]",
    require => Stingray::Exec["create virtual server $virtual_server_name"],
  }
}
