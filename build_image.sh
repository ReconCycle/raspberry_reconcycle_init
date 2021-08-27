#!/bin/bash

echo "Load and build docker package"

# Obtain dockerfile
cd $HOME/raspi_reconcycle_init
git clone https://github.com/ReconCycle/raspi-reconcycle-docker.git
cd raspi-reconcycle-docker

# Update ros:kinetic image to avoid https://discourse.ros.org/t/ros-gpg-key-expiration-incident/20669
docker pull ros:kinetic

#build image
docker build -t raspi-reconcycle .

