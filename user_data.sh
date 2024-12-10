#!/bin/bash
yum update -y
yum upgrade -y
yum install -y docker
systemctl start docker
systemctl enable docker

curl -L "https://github.com/docker/compose/releases/download/2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir -p /home/ec2-user/wordpress
cd /home/ec2-user/wordpress

cat <<EOL > docker-compose.yml
version: '3.8'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: <RDS_ENDPOINT>
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wp-data:/var/www/html

volumes:
  wp-data:
EOL

docker-compose up -d

echo "Docker, Docker Compose e WordPress configurados com sucesso."