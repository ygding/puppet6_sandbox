Vagrant.configure(2) do |config|

#  config.vbguest.auto_update = false

  config.vm.define "puppet", primary: true do |puppet|
    puppet.vm.hostname = "puppet"
    puppet.vm.box = "puppetlabs/centos-7.2-64-puppet"
    puppet.vm.box_version = "1.0.1"
    puppet.vm.network "private_network", ip: "10.13.37.2"
    puppet.vm.network :forwarded_port, guest: 8080, host: 8080, id: "puppetdb"
    puppet.vm.synced_folder "code", "/etc/puppetlabs/code"
    puppet.vm.provider :virtualbox do |vb|
      vb.memory = "3072"
    end

    puppet.vm.provision "shell", path: "puppetupgrade.sh"
    puppet.vm.provision "puppet" do |puppetapply|
      puppetapply.environment = "production"
      puppetapply.environment_path = ["vm", "/etc/puppetlabs/code/environments"]
    end
  end

# client nodes, puppet will instal matricbeat on it, it also used for test Zookeeper(kazoo), etc.
    config.vm.define "node1", primary: true do |node1|
      node1.vm.hostname = "node1"
      node1.vm.box = "puppetlabs/centos-7.2-64-puppet"
      node1.vm.box_version = "1.0.1"
      node1.vm.network "private_network", ip: "10.13.37.101"
      node1.vm.provision "shell", path: "puppetupgrade.sh"
      node1.vm.provision "shell", inline: "/bin/systemctl start puppet.service"
    end

    config.vm.define "node2", primary: true do |node2|
      node2.vm.hostname = "node2"
      node2.vm.box = "puppetlabs/centos-7.2-64-puppet"
      node2.vm.box_version = "1.0.1"
      node2.vm.network "private_network", ip: "10.13.37.102"
      node2.vm.provision "shell", path: "puppetupgrade.sh"
      node2.vm.provision "shell", inline: "/bin/systemctl start puppet.service"
    end

end
