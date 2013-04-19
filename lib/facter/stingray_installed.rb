# stingray_installed.rb

Facter.add("stingray_installed") do
  setcode do
    Facter::Util::Resolution.exec('test -d /usr/local/zeus')
  end
end