#!/bin/sh

if [ ! -f /etc/provisioned ] ; then

  # remove strange manually placed repo file
  /bin/yum -y remove puppetlabs-release-pc1
  /bin/rm -f /etc/yum.repos.d/puppetlabs*

  # install Puppet 6.x release repo
  /bin/yum -y install http://yum.puppetlabs.com/puppet6/puppet-release-el-7.noarch.rpm
#  /bin/yum -y install ./puppet-release-el-7.noarch.rpm
  if [ $? -ne 0 ] ; then
    echo "Something went wrong installing the repository RPM"
    exit 1
  fi

  # install / update puppet-agent
  /bin/yum -y install puppet-agent
  if [ $? -ne 0 ] ; then
    echo "Something went wrong installing puppet-agent"
    exit 1
  fi

  echo "10.13.37.2  puppet" >> /etc/hosts

  if [ `hostname` = "puppet" ]; then
    /bin/yum -y install puppetserver
    /usr/bin/systemctl enable puppetserver
    /usr/bin/systemctl start puppetserver
  fi
  touch /etc/provisioned
fi
