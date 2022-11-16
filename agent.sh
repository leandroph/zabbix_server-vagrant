# install net-tools
apt install -y net-tools
# packages
wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1%2Bfocal_all.deb
dpkg -i zabbix-release_5.0-1+focal_all.deb
apt update
# install zabbix agent
apt install zabbix-agent -y
# set server ip
sed 's/# Server=/Server=192.168.99.100/g' /etc/zabbix/zabbix_agentd.conf  -i
sed 's/# ServerActive=/ServerActive=192.168.99.100/g' /etc/zabbix/zabbix_agentd.conf  -i
# set hostname
sed 's/# Hostname=/Hostname=ZabbixServer/g' /etc/zabbix/zabbix_agentd.conf  -i
# restart and enable zabbix agent
systemctl restart zabbix-agent
systemctl enable --now zabbix-agent