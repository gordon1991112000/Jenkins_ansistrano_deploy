#!/bin/bash

####Prometheus
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.29.2/prometheus-2.29.2.linux-amd64.tar.gz
gzip -d prometheus-2.29.2.linux-amd64.tar.gz
tar -xvf prometheus-2.29.2.linux-amd64.tar
mv prometheus-2.29.2.linux-amd64 /usr/local/
ln -s /usr/local/prometheus-2.29.2.linux-amd64/ /usr/local/prometheus
useradd  -s /sbin/nologin -M prometheus 
mkdir  /data/prometheus -p
chown -R prometheus:prometheus /usr/local/prometheus/
chown -R prometheus:prometheus /data/prometheus/
echo "[Unit]
Description=Prometheus
Documentation=https://prometheus.io/
After=network.target
[Service]
Type=simple
User=prometheus
ExecStart=/usr/local/prometheus/prometheus --config.file=/usr/local/prometheus/prometheus.yml --storage.tsdb.path=/data/prometheus
Restart=on-failure
[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/prometheus.service

#####Grafana
wget https://dl.grafana.com/enterprise/release/grafana-enterprise-7.5.10.linux-amd64.tar.gz
tar -zxvf grafana-enterprise-7.5.10.linux-amd64.tar.gz
mv grafana-7.5.10 /usr/local/
ln -s /usr/local/grafana-7.5.10/ /usr/local/grafana
useradd -s /sbin/nologin -M grafana
mkdir /data/grafana
chown -R grafana:grafana /usr/local/grafana/ 
chown -R grafana:grafana  /data/grafana/
echo "[Unit]
Description=Grafana
After=network.target

[Service]
User=grafana
Group=grafana
Type=notify
ExecStart=/usr/local/grafana/bin/grafana-server -homepath /usr/local/grafana
Restart=on-failure

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/grafana-server.service
systemctl enable  grafana-server
systemctl start  grafana-server

