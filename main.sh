#!/usr/bin/bash

sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config ;setenforce 0

yum update -y && yum install nginx firewalld bash-completion  curl epel-release git open-vm-tools vim wget -y

cp grafana.conf /etc/nginx/conf.d/grafana.conf

systemctl restart nginx

firewall-cmd --add-port=81/tcp --permanent

firewall-cmd --reload

# Install docker-ce && docker-compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
yum install docker-compose -y

# Pull main images

docker pull prom/prometheus
docker pull grafana/grafana

docker-compose up -d

