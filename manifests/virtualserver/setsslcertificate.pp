# -*- mode: puppet -*-
# vi: set ft=puppet :

define stingray::virtualserver::setsslcertificate (
  $virtual_server = $title,
  $certificate,
) {

  stingray::exec { "Set default SSL Certificate for $virtual_serveer to $certificate" :
  	command => "VirtualServer.setSSLCertificate [\"$virtual_server\"] [\"$certificate\"]",
    require => [
      Stingray::Virtualserver::Addvirtualserver["$virtual_server"],
      Stingray::Catalog::Ssl::Certificates::Importcertificate["$certificate"],
    ],
  }
}