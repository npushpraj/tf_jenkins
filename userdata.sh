#!/bin/bash -v
apt-get update -y
apt-get upgrade
echo "This is after update" >> /tmp/pushpraj.txt
