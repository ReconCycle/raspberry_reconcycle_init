# raspberry_reconcycle_init

This repository contains the shell scripts and files required to automatically set up the Raspberry for the Reconcycle project.


In future work, this will be changed to docker-compose!

## System presetup

Preparing the new Raspberry for further work:

1. install Rasbian or use preinstalled card,

1. plug the Raspberry to the HDMI display and start the system,

1. update system, 

1. enable SSH (main menu -> settings -> Raspeberry Pi configurations -> interfaces -> enable SSH)

1. restart the system!

Now you can continue either via the desktop or via SSH (sudo ssh pi@x.x.x.x).

## Prepare file system

First clone this init repository

```sh
git clone https://github.com/ReconCycle/raspberry_reconcycle_init.git
```

Run init script to install Docker and create the required folders

```sh
cd raspberry_reconcycle_init/
chmod +x init.sh
./init.sh


```
In new terminal run container init script for preparing Docker image: https://github.com/ReconCycle/raspi-reconcycle-docker

```sh
cd $HOME/raspberry_reconcycle_init/
chmod +x init_container.sh
./init_container.sh
```


## Set up specific raspberry 


```sh
cd $HOME/reconcycle_config/
```

### Set the name of your tool (this will later be the name for the ROS namespace). 

Open the following file in an editor and write the name you have chosen
```sh
nano node_name.txt
```

### Set ROS_MASTER_URI

Open the following file in an editor and correct to the IP of computer that will run your ROS master. It must have the http:// prefix, for example
http://192.168.0.1:11311/

```sh
nano master_link.txt
```

Restart Raspberry (or docker) for activating new settings 

[CHECK](http://wiki.ros.org/ROS/NetworkSetup) network configuration if AF_INET error!

### Set ROS_IP

Find your Raspberry's IP with ifconfig, and write it to ros_ip.txt, for example 192.168.0.1    (there must not be http:// prefix!)

```sh
nano ros_ip.txt
```





## Update (when you make changes to the packages building the raspi docker) 

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

## Optional: Set correct NTP

```bash
sudo apt-get install ntp

sudo apt-get install ntpdate

sudo service ntp stop

sudo ntpdate goodtime.ijs.si

sudo service ntp start

sudo timedatectl set-timezone Europe/Ljubljana
```


