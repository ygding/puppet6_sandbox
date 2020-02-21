# class to deploy master node:
# - puppetserver
# - puppetdb

class master {

  include ::firewall

  package { 'puppetserver':
    ensure  =>  'installed',
  }

  package { 'pdk':
    ensure => 'installed',
  }

  package { 'puppet-bolt':
    ensure => 'installed',
  }

  file { '/etc/systemd/system/puppetserver.service.d':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  firewall { '8140 accept - puppetserver':
    dport  => '8140',
    proto  => 'tcp',
    action => 'accept',
  }

  service { 'puppetserver.service':
    ensure  => 'running',
    enable  => 'true',
    require => Package['puppetserver'],
  }

  file { '/etc/systemd/system/puppetserver.service.d/local.conf':
    ensure  => 'file',
    content => "[Service]\nTimeoutStartSec=500",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/systemd/system/puppetserver.service.d'],
    notify  => Service['puppetserver.service'],
  }

  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => 'file',
    content => '*',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['puppetserver'],
    notify  => Service['puppetserver.service'],
  }

  class { '::puppetdb':
    ssl_listen_address => '0.0.0.0',
    listen_address     => '0.0.0.0',
    open_listen_port   => true,
  }
  class { '::puppetdb::master::config':
    puppetdb_server         => 'puppet',
    strict_validation       => false,
    manage_report_processor => true,
    enable_reports          => true,
    restart_puppet          => false,
  }
}
