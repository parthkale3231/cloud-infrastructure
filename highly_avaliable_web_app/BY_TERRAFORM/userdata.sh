#!/bin/bash

yum update -y

yum install -y python3

mkdir -p /home/ec2-user/app

cd /home/ec2-user/app

echo "<h1>AWS Terraform Project Working</h1>" > index.html

nohup python3 -m http.server 3000 > server.log 2>&1 &