#!/bin/bash

echo "Setup Raspberry for Reconcycle project"



# update the system







## install docker package

#Downloading the installation script with:

curl -fsSL https://get.docker.com -o get-docker.sh

#Execute the script using the command:

sudo sh get-docker.sh

# Add user to sudo docker

sudo usermod -aG docker $USER





# build the docker image






# setup automatic start of docker container





# prepare stuff for start

mkdir $HOME/reconcycle_config

export $ROS_MASTER_URI=$(<master_link.txt)
