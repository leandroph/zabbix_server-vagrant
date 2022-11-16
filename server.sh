# install net-tools
apt install -y net-tools
# install mysql
apt install mysql-server mysql-client -y
systemctl start mysql
systemctl enable --now mysql
# packages
wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1%2Bfocal_all.deb
dpkg -i zabbix-release_5.0-1+focal_all.deb
apt update
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent -y
# set date.timezone in php.ini
sed -i 's|;date.timezone =|date.timezone = America/Sao_Paulo|' /etc/php/7.4/apache2/php.ini
# configure mysql
echo -e "[mysqld]\ndefault-storage-engine = innodb" | sudo tee /etc/mysql/conf.d/mysqld.conf
systemctl restart mysql
mysql -uroot -e "create database zabbix character set utf8 collate utf8_bin;"
mysql -uroot -e "create user zabbix@localhost identified by 'zabbix';"
mysql -uroot -e "grant all privileges on zabbix.* to zabbix@localhost;"
mysql -uroot -e "flush privileges;"
# extract the schema from the Zabbix server package and load it into the database:
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql -uzabbix -p"zabbix" zabbix
# set password in zabbiz_server.conf
sed 's/# DBPassword=/DBPassword=zabbix/g' /etc/zabbix/zabbix_server.conf -i
# restart zabbix server and apache
service zabbix-server restart
service apache2 restart