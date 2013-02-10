# = Define: stingray::command
#
# Execute a command in the stingray CLI.
#
# == Parameters
#
# [*version*]
#   Version to install.
#
# [*absent*]
#   true to ensure package isn't installed.
#
# [*notify_service*]
#   If you want to restart a service automatically when
#   the module is applied. Default: true
#
# [*service_autorestart*]
#   wathever we want a module installation notify a service to restart.
#
# [*service*]
#   Service to restart.
#
# [*module_prefix*]
#   If package name prefix isn't standard.
#
# == Examples
# php::module { 'gd': }
#
# php::module { 'gd':
#   ensure => absent,
# }
#
# This will install php-apc on debian instead of php5-apc
#
# php::module { 'apc':
#   module_prefix => "php-",
# }
#
# Note that you may include or declare the php class when using
# the php::module define
#
define stingray::exec (
  $command,
  $host     = $stingray::host,
  $port     = $stingray::port,
  $username = $stingray::username,
  $password = $stingray::password,
  $path     = $stingray::path
) {
  exec { "execute stingray command: $name" : 
    command => template("stingray/command.erb"),
    path => ["/bin", "/usr/bin", $path],
    logoutput => true,
    require => [
      Service["zeus"],
      Package["unzip"],
    ],
  }
}
