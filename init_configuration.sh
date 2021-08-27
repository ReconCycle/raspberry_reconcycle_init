#!/bin/bash

echo "Setup Raspberry for Reconcycle project"


# update the system
echo "--------------------------------------------------------------------"
echo "Please enter name for this configuration (e.g. cutter)"
read NAME
echo "Please enter ROS_MASTER_URI (e.g. http://10.20.0.1:11311):"
read ROS_MASTER_URI
echo "Please enter ROS_IP (IP of this raspberry, e.g. 10.20.1.99):"
read ROS_IP
echo "--------------------------------------------------------------------"


echo "Create folders"

## prepare stuff for start

# create folder that will contain pernament data and will be attached to docker

export RECONCYCLE_CONFIG=$HOME/${NAME}_config

mkdir $RECONCYCLE_CONFIG

# put in this folder initial master adress and hardware interface
cat > $RECONCYCLE_CONFIG/docker-compose.yaml <<- EOM
version: '3'
services:
  raspi_ros:
    image: raspi-reconcycle
    environment:
      -  ROS_MASTER_URI=$ROS_MASTER_URI
      - ROS_IP=$ROS_IP
      - THIS_RAS_NAME=$NAME
    devices:
      - /dev/mem
    volumes:
      - $RECONCYCLE_CONFIG:/reconcycle_config
    privileged: true
    network_mode: "host"
    restart: always
EOM

#set dynamic startup
#cp raspi-reconcycle-docker/dynamic_startup-template.sh $RECONCYCLE_CONFIG/dynamic_startup.sh
cat > $RECONCYCLE_CONFIG/dynamic_startup.sh <<- EOM
#!/usr/bin/env bash
echo "Dynamic startup"
source /source_ws.sh
echo Using ROS_MASTER_URI=$ROS_MASTER_URI
echo Using ROS_IP=$ROS_IP
roslaunch --wait raspi_ros reconcycle.launch

exec "$@"
EOM
chmod +x $RECONCYCLE_CONFIG/dynamic_startup.sh

#copy template configuration
cp -r active_config-template $RECONCYCLE_CONFIG/active_config


echo "DONE. Configuration is stored to $RECONCYCLE_CONFIG"


