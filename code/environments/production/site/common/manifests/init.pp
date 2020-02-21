# common class that gets applied to all nodes
# See: "code/environments/production/hieradata/common.yaml"
# It:
#  - configures /etc/hosts entries
#  - makes sure puppet is installed and running
#  - makes sure mcollective + client is installed and running
#
class common {

  # needed for rubygem-stomp
  yumrepo { 'puppetlabs-deps':
    ensure  => 'present',
    baseurl => 'http://yum.puppetlabs.com/el/7/dependencies/$basearch',
    descr   => 'Puppet Labs Dependencies El 7 - $basearch',
    enabled => '1',
  }

  #nodes declaration
  @@host { $facts['networking']['hostname']:
    ip  => $facts['ipaddress_enp0s8'],
#    tag => ['hosttag'],
  }
  Host <<||>>
  #Host <<|tag == 'hosttag'|>>

  package { 'puppet-agent':
    ensure => installed,
  }

  service { 'puppet':
    ensure  => running,
    enable  => true,
    require => Package['puppet-agent'],
  }

  if $facts['hostname'] !~ /puppet*/ {
    service { 'firewalld':
      ensure => 'stopped',
      enable => 'false',
    }
  }
}
