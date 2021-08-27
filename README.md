# raspberry_reconcycle_init

This repository contains the shell scripts and files required to automatically set up the Raspberry for the Reconcycle project.

## System presetup

Preparing the new Raspberry for further work:

1. install Rasbian or use preinstalled card,
2. plug the Raspberry to the HDMI display and start the system,
3. enable SSH (main menu -> settings -> Raspeberry Pi configurations -> interfaces -> enable SSH)
4. update and restart the system!

Now you can continue either via the desktop or via SSH (sudo ssh pi@x.x.x.x).

## Prepare the file system

First clone this template repository

```sh
git clone https://github.com/ReconCycle/raspberry_reconcycle_init.git
```

Run the initialisation script to install docker configuration and create the required folders

```sh
cd raspberry_reconcycle_init/
chmod +x init.sh
./init.sh
```

<!--
In a new terminal run container init script for preparing Docker image: https://github.com/ReconCycle/raspi-reconcycle-docker

```sh
cd $HOME/raspberry_reconcycle_init/
chmod +x init_container.sh
./init_container.sh
```
-->

## Set up the specific raspberry 

Open the docker-compose.yaml template.
```sh
cd $HOME/reconcycle_config
nano node_name.txt
```

Scroll to the environment variables section:

```yaml
    environment:
      - ROS_MASTER_URI=http://10.20.0.1:11311
      - ROS_IP=10.20.1.XXX
      - THIS_RAS_NAME='example'
```

1. Set `ROS_MASTER_URI` to have the correct IP of the computer that runs ROS master. The variable must include the protocol and port, for example
http://192.168.0.1:11311
2. Set `ROS_IP` to match with the Raspberry's IP. Find your Raspberry's IP with ifconfig, and write it to ros_ip.txt, for example 192.168.0.1
3. Set the name of your tool (this will later be the name for the ROS namespace) by changing the `THIS_RAS_NAME`.

[CHECK](http://wiki.ros.org/ROS/NetworkSetup) network configuration if AF_INET error!


<!-- ## Update (when you make changes to the packages building the raspi docker) 

```sh
docker container stop ros1_active
docker container rm ros1_active
cd $HOME/raspi_reconcycle_docker
docker image rm raspi:active
docker build -t raspi:active .
docker run -d -v $HOME/reconcycle_config/:/reconcycle_config/ --net=host --device /dev/mem --privileged --name ros1_active raspi:active
```


## Optional: Prepare startup rutine with crontab

Open
```sh

crontab -e

```

Copy this in file and set that 60 seconds after reboot runs the docker
```bash

@reboot sleep 60 && docker container restart ros1_active  && echo "restarting docker" | wall

```
-->

## Optional: Set correct NTP

```bash
sudo apt-get install ntp ntpdate

sudo service ntp stop

sudo ntpdate goodtime.ijs.si

sudo service ntp start

sudo timedatectl set-timezone Europe/Ljubljana
```


