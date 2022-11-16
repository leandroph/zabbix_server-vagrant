# -*- mode: ruby -*-
# vi: set ft=ruby  :

machine_zabbix = {
  "ZabbixServer" => {"memory" => "1024", "cpu" => "1", "ip" => "100", "image" => "ubuntu/focal64"},
  "Agent01" => {"memory" => "1024", "cpu" => "1", "ip" => "101", "image" => "ubuntu/focal64"},
  "Windows10" => {"memory" => "1024", "cpu" => "1", "ip" => "102", "image" => "gusztavvargadr/windows-10"}
}

Vagrant.configure("2") do |config|

  machine_zabbix.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}"
      machine.vm.network "private_network", ip: "192.168.99.#{conf["ip"]}"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        
      end
      #machine.vm.provision "shell", path: "server.sh"
      if "#{name}" == "ZabbixServer"  
        machine.vm.provision "shell", path: "server.sh"
      else
        machine.vm.provision "shell", path: "agent.sh"
      end

    end
  end
end
