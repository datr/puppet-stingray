# -*- mode: puppet -*-
# vi: set ft=puppet :

define stingray::virtualserver::setssldecrypt (
  $virtual_server,
  $enabled = "true",
) {

  stingray::exec { "Set SSL Decrpytion for $virtual_serveer to $enabled" :
  	command => "VirtualServer.setSSLDecrypt [\"$virtual_server\"] [ $enabled ]",
    require => [
      Stingray::Virtualserver::Setsslcertificate["$virtual_server"],
    ],
  }
}