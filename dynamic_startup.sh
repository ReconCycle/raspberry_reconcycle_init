#!/usr/bin/env bash
echo "Dynamic startup!"
source /source_ws.sh
echo $ROS_MASTER_URI
echo $ROS_IP
roslaunch --wait raspi_ros reconcycle.launch 

exec "$@"
