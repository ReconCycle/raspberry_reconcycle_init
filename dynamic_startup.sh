#!/usr/bin/env bash
echo "Dynamic startup!"
source /source_ws.sh
export ROS_MASTER_URI=$(</reconcycle_config/master_link.txt)
export THIS_RAS_NAME=$(</reconcycle_config/node_name.txt)
export ROS_IP=$(</reconcycle_config/ros_ip.txt)
echo $ROS_MASTER_URI
echo $ROS_IP
roslaunch --wait raspi_ros reconcycle.launch 

exec "$@"
