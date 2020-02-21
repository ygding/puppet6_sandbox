# puppet 6 test/development environment

### About
The environment including one puppet 6 server and two nodes(node1, node2)

### Requirements
The environment tested under:
- VirtualBox version 5.2+
- Vagrant version 2.0+

### Puppet Package build-in
```yaml
package { 'puppet':
  ensure => ['6.0.2'],
}
package { 'puppet-agent':
  ensure => '6.0.2-1.el7',
}
package { 'puppet-release':
  ensure => '1.0.0-3.el7',
}
package { 'puppet-resource_api':
  ensure => ['1.6.0'],
}
package { 'puppetdb':
  ensure => '6.0.0-1.el7',
}
package { 'puppetdb-termini':
  ensure => '6.0.0-1.el7',
}
package { 'puppetserver':
  ensure => '6.0.1-1.el7',
}
package { 'puppetserver-ca':
  ensure => ['1.1.1'],
}
package { 'pdk':
  ensure => '1.7.1.0-1.el7',
}
package { 'puppet-bolt':
  ensure => '1.0.0-1.el7',
}
```
***MCollective and ActiveMQ have been removed from PE 2019/Puppet 6***

### Usage
After cloning the repository make sure the submodules are also updated:  
```
$ git clone git@github.pie.apple.com:thomas-ding/puppet6.git
$ cd puppet6
$ git submodule update --init --recursive
```

Startup command:
```
$ vagrant up
```
Login to puppet server or node:
```
$ vagrant ssh puppet
$ vagrant ssh node1
$ vagrant ssh node2
```
