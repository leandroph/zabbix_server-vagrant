# -*- mode: ruby -*-
# vi: set ft=ruby  :

machine_zabbix = {
  "ZabbixServer" => {"memory" => "1024", "cpu" => "1", "ip" => "100", "image" => "ubuntu/focal64"}
}

Vagrant.configure("2") do |config|

  machine_zabbix.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}"
      machine.vm.network "private_network", ip: "192.168.99.#{conf["ip"]}"
      #machine.vm.network "private_network", guest: 80, host: 8080
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        
      end
      machine.vm.provision "shell", inline: <<-SHELL
        # install net-tools
        apt install -y net-tools;
        # install mysql
        apt install mysql-server mysql-client -y;
        systemctl start mysql;
        systemctl enable --now mysql;
        # packages
        wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1%2Bfocal_all.deb;
        dpkg -i zabbix-release_5.0-1+focal_all.deb;
        apt update;
        apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent -y;
        #sed 's@#date.timezone =@date.timezone=America/Sao_Paulo@' -i /etc/zabbix/apache.conf;
        sed 's/# php_value date.timezone Europe\/Riga/php_value date.timezone America\/Sao_Paulo/' /etc/zabbix/apache.conf;
        # configure mysql
        echo -e "[mysqld]\ndefault-storage-engine = innodb" | sudo tee /etc/mysql/conf.d/mysqld.conf;
        systemctl restart mysql;
        mysql -uroot -e "create database zabbix character set utf8 collate utf8_bin;";
        mysql -uroot -e "create user zabbix@localhost identified by 'zabbix';";
        mysql -uroot -e "grant all privileges on zabbix.* to zabbix@localhost;";
        mysql -uroot -e "flush privileges;";
        # Extract the schema from the Zabbix server package and load it into the database:
        zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql -uzabbix -p"zabbix" zabbix;
        # set password in zabbiz_server.conf
        sed 's/# DBPassword=/DBPassword=zabbix/g' /etc/zabbix/zabbix_server.conf -i;
        # resart zabbix server and apache
        service zabbix-server restart;
        service apache2 restart;
      SHELL

    end
  end
end
