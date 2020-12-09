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

## prepare stuff for start

# create folder that will contain pernament data and will be attached to docker

mkdir $HOME/reconcycle_config

# put in this folder initial master adress and hardware interface
cp master_link.txt $HOME/reconcycle_config


cp raspberry_reconcycle_init/active_config $HOME/reconcycle_config/ -r




# build the docker image
git clone https://github.com/ReconCycle/raspi-reconcycle-docker.git
cd raspi-reconcycle-docker
docker build -t raspi:active .




# setup automatic start of docker container

docker run -d --restart always -v $HOME/reconcycle_config:/reconcycle_config --device /dev/mem --privileged --name ros1_active raspi:active

docker run -it --device /dev/mem --privileged --name ros1_active raspi:active





export $ROS_MASTER_URI=$(<master_link.txt)
