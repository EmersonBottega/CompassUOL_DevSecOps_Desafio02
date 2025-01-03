#!/bin/bash
sudo su

yum update -y
yum upgrade -y
yum install docker -y
yum install nfs-utils -y
systemctl start docker
systemctl enable docker

mkdir -p /mnt/efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport <nomeDnsSeuEfs>:/ /mnt/efs
chown ec2-user:ec2-user /mnt/efs

mkdir -p /usr/lib/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-linux-x86_64 -o /usr/lib/docker/cli-plugins/docker-compose
chmod +x /usr/lib/docker/cli-plugins/docker-compose

mkdir -p /home/ec2-user/wordpress
cd /home/ec2-user/wordpress

cat <<EOL > docker-compose.yml
version: '3.8'

services:
  wordpress:
    image: wordpress:latest
    container_name: wordpress-app
    ports:
      - 80:80
    environment:
      WORDPRESS_DB_HOST: <endpointSeuRDS>
      WORDPRESS_DB_USER: nomeSeuUsuario
      WORDPRESS_DB_PASSWORD: suaSenha
      WORDPRESS_DB_NAME: nomeSeuDB
    volumes:
      - wp-data:/var/www/html
      - /mnt/efs:/var/www/html/
    restart: always

volumes:
  wp-data:
EOL

cat <<EOF > /mnt/efs/healthcheck.php
<?php
http_response_code(200);
header('Content-Type: application/json');
echo json_encode(["status" => "OK", "message" => "Health check passed"]);
exit;
?>
EOF

usermod -aG docker ec2-user
newgrp docker
chown -R ec2-user:ec2-user /home/ec2-user/wordpress

docker compose -f /home/ec2-user/wordpress/docker-compose.yml up -d