class userprefs::bash (
  $default  = true,
  $password = undef,
  $replace  = false,
) {
  package { 'bash':
    ensure => present,
  }

  file { '/root/.bashrc':
    ensure  => file,
    replace => $replace,
    source  => 'puppet:///modules/userprefs/shell/bashrc',
    require => Package['bash'],
  }

  file { '/root/.bash_profile':
    ensure  => file,
    replace => $replace,
    source  => 'puppet:///modules/userprefs/shell/bash_profile',
    require => Package['bash'],
  }

  file { '/root/.bashrc.puppet':
    ensure  => file,
    source  => 'puppet:///modules/userprefs/shell/bashrc.puppet',
    require => Package['bash'],
  }

  if $default {
    user { 'root':
      ensure   => present,
      shell    => '/bin/bash',
      password => $password,
      require  => Package['bash'],
    }
  }
}
