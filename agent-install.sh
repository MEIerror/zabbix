#!/bin/bash

SERVER_IP=192.168.1.82
WORK_DIR='/usr/local/zabbix-agent'
URL='http://192.168.1.38/ambari/tools/zabbix/zabbix-3.4.9.tar.gz'



install() {
useradd zabbix
yum install pcre* -y
cd /opt
wget $URL
tar -zxf /opt/zabbix-3.4.9.tar.gz -C /opt/
cd /opt/zabbix-3.4.9
./configure --prefix=/usr/local/zabbix-agent --enable-agent && make install
cp /usr/local/zabbix-agent/sbin/zabbix_agentd /etc/init.d/
}

conf() {
cat > ${WORK_DIR}/etc/zabbix_agentd.conf <<EOF
LogFile=/tmp/zabbix_agentd.log
Server=$SERVER_IP
ServerActive=$SERVER_IP
Hostname=$HOSTNAME
EnableRemoteCommands=1
LogRemoteCommands=1
EOF

}


install
conf
