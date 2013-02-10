define stingray::pool::addpool (
  $pool_name = $title,
  $host,
  $port,
) {
  stingray::exec { "create pool $pool_name" :
    command => "Pool.addPool [\"$pool_name\"] [[\"$host:$port\"]]",
  }
}
