#!/bin/bash

echo "Setup Raspberry for Reconcycle project"



# update the system




## prepare stuff for start

# create folder that will contain pernament data and will be attached to docker

mkdir $HOME/reconcycle_config

# put in this folder initial master adress and hardware interface
#set dynamic startup

cp master_link.txt $HOME/reconcycle_config
cp node_name.txt $HOME/reconcycle_config
cp dynamic_startup.sh $HOME/reconcycle_config

cp active_config $HOME/reconcycle_config/ -r

cd $HOME

## install docker package

#Downloading the installation script with:

curl -fsSL https://get.docker.com -o get-docker.sh

#Execute the script using the command:

sudo sh get-docker.sh

# Add user to sudo docker

sudo usermod -aG docker $USER


# build the docker image
git clone https://github.com/ReconCycle/raspi-reconcycle-docker.git
cd raspi-reconcycle-docker
docker build -t raspi:active .





# setup automatic start of docker container

docker run -d -v $HOME/reconcycle_config/:/reconcycle_config/ --net=host --restart always --device /dev/mem --privileged --name ros1_active raspi:active

