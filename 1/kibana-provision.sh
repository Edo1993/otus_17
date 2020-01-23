#!/bin/bash

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
 
echo "Adding Kibana repository kibana.repo."
touch '/etc/yum.repos.d/kibana.repo'
echo "[kibana-5.x]
name=Kibana repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" > '/etc/yum.repos.d/kibana.repo'
 
yum install -y kibana 
 
# Making sure Kibana service starts automatically on system bootup
systemctl daemon-reload
systemctl enable kibana.service
 
# Start Kibana 
systemctl start kibana.service
service kibana status
 
echo "Now I will sleep for 11 seconds and then verify if elastic search API is reachable."
n=0
while (( $n <= 11 ));
do
	echo -n ".";
	sleep 1;
	((n++));
done
 
if curl -XGET http://127.0.0.1:5601;
then
	echo "Seems like Kibana is up and running. Don't forget to set up whatever is needed in /etc/kibana/"
	exit 0;
else
	echo "ERROR: Can't reach Kibana!"
	exit 1;
fi
