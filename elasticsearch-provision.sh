#!/bin/bash

yum install wget -y
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
 
echo "Adding Elasticsearch repository elastic.repo."
touch '/etc/yum.repos.d/elastic.repo'
echo "[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://packages.elastic.co/elasticsearch/5.x/centos
gpgcheck=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1" > '/etc/yum.repos.d/elastic.repo'
 
yum install -y java elasticsearch 
 
echo "Making sure Elastic-Search service starts automatically on system bootup"
systemctl daemon-reload
systemctl enable elasticsearch.service
 
echo "Start Elastic-Search service"
systemctl start elasticsearch.service
service  elasticsearch status
 
echo "Now I will sleep for 11 seconds and then verify if elastic search API is reachable."
n=0
while (( $n <= 11 ));
do
	echo -n ".";
	sleep 1;
	((n++));
done
 
if curl -XGET http://127.0.0.1:9200;
then
	echo "Seems like ElasticSearch is up and running. Don't forget to set up whatever is needed in /etc/elasticsearch/"
	exit 0;
else
	echo "ERROR: Can't reach ElasticSearch!"
	exit 1;
fi
