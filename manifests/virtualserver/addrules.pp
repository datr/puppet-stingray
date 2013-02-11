# -*- mode: puppet -*-
# vi: set ft=puppet :

define stingray::virtualserver::addrules (
  $virtual_server,
  $rule,
  $run_frequency = "run_every",
  $enabled = "true"
) {
  # Check the rule
  stingray::exec { "add $rule to $virtual_server" :
  	command => "VirtualServer.addRules [\"$virtual_server\"] [ { enabled: $enabled, name: \"$rule\", run_frequency: $run_frequency } ]",
    require => [
      Stingray::Virtualserver::Addvirtualserver["$virtual_server"],
      Stingray::Rule::Upload["$rule"],
    ],
  }
}