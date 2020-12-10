#!/usr/bin/env bash
echo "Dynamic startup!"
source /source_ws.sh
export ROS_MASTER_URI=$(</reconcycle_config/master_link.txt)
export THIS_RAS_NAME=$(</reconcycle_config/node_name.txt)
echo $ROS_MASTER_URI
roslaunch raspi_ros reconcycle.launch 

exec "$@"
