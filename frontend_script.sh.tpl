#!/bin/bash

sudo yum update -y

sudo yum install nginx -y

sudo amazon-linux-extras install nginx1

sudo yum install epel-release -y

sudo amazon-linux-extras enable epel -y

sudo nginx


