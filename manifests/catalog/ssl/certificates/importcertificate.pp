# -*- mode: puppet -*-
# vi: set ft=puppet :

define stingray::catalog::ssl::certificates::importcertificate (
  $private_key_file,
  $public_cert_file,
) {
  # zcli expects the contents of the files in one long string rather than
  # filenames. Why? I don't know. It also don't support multi line arguments
  # and its cert tool doesn't support single line keys (sigh). So we escape all
  # the new line characters.
  # See discussion here: http://splash.riverbed.com/thread/5133
  #
  # We use template() instead of file() because template supports() puppet file
  # paths where as file does not. See
  # http://projects.puppetlabs.com/issues/1946
  $private_key_contents = template($private_key_file)
  $private_key_string = regsubst($private_key_contents, '\n', '\\n', 'G')

  $public_cert_contents = template($public_cert_file)
  $public_cert_string = regsubst($public_cert_contents, '\n', '\\n', 'G')

  stingray::exec { "import certificate $title" :
  	command => "Catalog.SSL.Certificates.importCertificate [\"$title\"] [ { private_key: \"$private_key_string\", public_cert: \"$public_cert_string\" } ]",
  }
}