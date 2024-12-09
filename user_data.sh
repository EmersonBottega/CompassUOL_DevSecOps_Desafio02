#!/bin/bash
yum update -y
yum upgrade -y
yum install -y docker
systemctl start docker
systemctl enable docker

curl -L "https://github.com/docker/compose/releases/download/2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Docker instalado e configurado."