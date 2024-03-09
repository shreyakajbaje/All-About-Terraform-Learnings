#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo systemctl start nginx

# User data scripts only run at first boot whereas the instance modification causes a reboot