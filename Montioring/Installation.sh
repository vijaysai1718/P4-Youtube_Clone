#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
Normal="\e[0m"
user=$(id -u)

if [ $user -ne 0 ] 
then 
echo "please run  script with the super user"
exit 1
else
echo "you are the super user installation will be inprogress"
fi
#function for validation
validate()
if [ $1 -ne 0 ]
then 
echo -e "Installation of $2 is $RED Failure $Normal"
exit
else
echo -e "Installation of $2 is $GREEN Success $Normal"
fi


 apt update &&  apt upgrade -y
 apt install prometheus prometheus-node-exporter -y
 systemctl enable --now prometheus prometheus-node-exporter
systemctl status prometheus
systemctl status prometheus-node-exporter
# Install dependencies
 apt install -y gnupg2 apt-transport-https software-properties-common wget
# Add Grafana GPG key
wget -q -O - https://packages.grafana.com/gpg.key |  apt-key add -
# Add Grafana repository
echo "deb https://packages.grafana.com/oss/deb stable main" |  tee /etc/apt/sources.list.d/grafana.list
# Update package list
 apt update
# Install Grafana
 apt install grafana -y
 systemctl enable --now grafana-server

# #once done confirue like below
# # nano /etc/prometheus/prometheus.yml
#   - job_name: node
#     # If prometheus-node-exporter is installed, grab stats about the local
#     # machine by default.
#     static_configs:
#       - targets: ['<MonitoringServerIp>:9100']
#   - job_name: jenkins
#     metrics_path: '/prometheus'
#     static_configs:
#       - targets: ['<JenkinsSeverIp>:8080']
#   - job_name: 'k8cluster'
#     metrics_path: '/metrics'
#     static_configs:
#       - targets: ['<nodeIp>:9100']


# #In cluster create a prothemeus using helm
# Install the Node Exporter using Helm:
# helm install prometheus-node-exporter prometheus-community/prometheus-node-exporter --namespace prometheus-node-exporter

# The default port for Grafana is 3000
# http://<monitoring-server-ip>:3000
# You will see the Grafana dashboard
# Adding Data Source in Grafana
# The first thing that we have to do in Grafana is to add the data source
# Add the data source;

#  Adding Dashboards in Grafana 
# (URL: https://grafana.com/grafana/dashboards/1860-node-exporter-full/) 
# Lets add another dashboard for Jenkins;
# (URL: https://grafana.com/grafana/dashboards/9964-jenkins-performance-and-health-overview/)

# Click on Dashboards in the left pane, you can see both the dashboards you have just added.