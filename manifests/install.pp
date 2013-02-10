# -*- mode: puppet -*-
# vi: set ft=puppet :

class stingray::install {
  exec { 'download stingray':
    command => "wget https://support.riverbed.com/download.htm?filename=public/software/stingray/trafficmanager/9.1/ZeusTM_91_Linux-x86_64.tgz -O ZeusTM_91_Linux-x86_64.tgz",
    cwd => '/tmp',
    path => ["/bin", "/usr/bin"],
    creates => "/tmp/ZeusTM_91_Linux-x86_64.tgz",
    # The file is 175mb. A 200kb connection (standard for the ADC proxy) will
    # take a little under 15 minutes to donwload the file.
    timeout => 1200,
  }

  file { '/opt/riverbed' : 
    ensure => 'directory',
  }

  file { '/opt/riverbed/stingray' : 
    ensure => 'directory',
    require => File['/opt/riverbed'],
  }

  exec { 'extract stingray' : 
    # --strip removes the top level container directory ZeusTM_91_Linux-x86_64/
    command => 'tar -zxvf /tmp/ZeusTM_91_Linux-x86_64.tgz --strip 1 --directory=/opt/riverbed/stingray',
    path => '/bin',
    creates => "/opt/riverbed/stingray/zinstall",
    require => [Exec['download stingray'], File['/opt/riverbed/stingray']],
  }

  file { "/opt/riverbed/stingray/stingray.conf" :
    source => "puppet://${server}/modules/stingray/stingray.conf",
    require => File['/opt/riverbed/stingray'],
  }

  exec { 'install stingray' : 
    command => '/opt/riverbed/stingray/zinstall --noninteractive --replay-from=/opt/riverbed/stingray/stingray.conf',
    path => ['/bin', '/usr/bin'],
    creates => "/usr/local/zeus",
    require => [Exec['extract stingray'], File["/opt/riverbed/stingray/stingray.conf"]],
  }

  # We configure separately as if zxtm!perform_initial_config to y then this
  # command is called without passing the replay file.
  exec { "configure stingray" :
    command => "/usr/local/zeus/zxtm/configure --noninteractive --replay-from=/opt/riverbed/stingray/stingray.conf",
    path => ['/bin', '/usr/bin'],
    logoutput => true,
    require => Exec["install stingray"],
  }

  # Unzip is needed by the cli
  package { "unzip" : }

  service { "zeus":
    ensure => running,
    require => Exec["configure stingray"],
  }
}