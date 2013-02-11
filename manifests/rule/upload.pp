# -*- mode: puppet -*-
# vi: set ft=puppet :

define stingray::rule::upload (
  $rule_name = $title,
  $file,
) {
  # Check the rule
  stingray::exec { "check rule $rule_name" :
  	command => "rule check $file",
  }

  # Create the rule
  stingray::exec { "add rule $rule_name" :
    command => "rule upload $file $rule_name",
    require => Stingray::Exec["check rule $rule_name"],
  }
}