#!/bin/bash

sudo yum update -y

sudo yum install -y httpd

sudo systemctl enable httpd

echo "<h1>I am from backend server</h1>" > /var/www/html/index.html

sudo systemctl start httpd

sudo yum search docker -y

sudo yum install docker -y

sudo yum install python3-pip -y

sudo pip3 install docker-compose

sudo systemctl enable docker.service

sudo systemctl start docker.service

sudo chmod 666 /var/run/docker.sock
