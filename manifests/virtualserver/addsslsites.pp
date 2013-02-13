# -*- mode: puppet -*-
# vi: set ft=puppet :

define stingray::virtualserver::addsslsites (
  $virtual_server,
  $certificate,
  $destination_address
) {

  stingray::exec { "Add $certificate to $virtual_server for $destination_address" :
  	command => "VirtualServer.addSSLSites [\"$virtual_server\"] [ { certificate: \"$certificate\", dest_address: \"$destination_address\" } ]",
    require => [
      Stingray::Virtualserver::Addvirtualserver["$virtual_server"],
      Stingray::Catalog::Ssl::Certificates::Importcertificate["$certificate"],
    ],
  }
}