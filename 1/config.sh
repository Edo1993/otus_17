#!/bin/bash

echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
echo "server.host: 0.0.0.0" >> /etc/kibana/kibana.yml
echo "elasticsearch.url: "http://localhost:9200"" >> /etc/kibana/kibana.yml

service elasticsearch restart
service kibana restart
curl -XPOST http://localhost:9201/catalog/products -d '{ "hello": "world" }'

