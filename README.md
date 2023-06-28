# raspberry_reconcycle_init

This repository contains the shell scripts and files required to automatically set up the Raspberry for the Reconcycle project.

## System setup

Preparing the new Raspberry for further work:

* install Rasbian or use preinstalled card,
* plug the Raspberry to the HDMI display and start the system,
* enable SSH (main menu -> settings -> Raspeberry Pi configurations -> interfaces -> enable SSH)
* Install docker and docker compose:
```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt-get install libffi-dev libssl-dev python3-pip
#sudo pip3 install docker-compose
sudo apt install docker-compose
```
* Add user to docker group 
```sh
sudo usermod -aG docker $USER
```
*  Restart the raspberry.

Now you can continue either via the desktop or via SSH (sudo ssh pi@x.x.x.x).

## Prepare the file system

First clone this template repository

```sh
git clone https://github.com/ReconCycle/raspberry_reconcycle_init.git
```

Run the initialisation script to install docker configuration and create the required folders

```sh
./init_configuration.sh
```

This script will ask you for a few details:
1. Set `ROS_MASTER_URI` to have the correct IP of the computer that runs ROS master. The variable must include the protocol and port, for example
http://192.168.0.1:11311
2. Set `ROS_IP` to match with the Raspberry's IP. Find your Raspberry's IP with ifconfig, and write it to ros_ip.txt, for example 192.168.0.1
3. Set `TOOL_NAME` the name of your tool (this will later be the name for the ROS namespace).

A new folder "`TOOL_NAME`_config"  containing the configuration, will be created in your home directory (you can access it using `cd ~/$RECONCYCLE_CONFIG`).


## Build docker image

Run the build script for preparing the [raspi-reconcycle-docker](https://github.com/ReconCycle/raspi-reconcycle-docker) docker image.

```sh
./build_image.sh
```


## Start docker-compose service

You're all set. Change to the directory containing configuration and start the docker with:

```sh
cd $RECONCYCLE_CONFIG
docker-compose up -d
```

### Restarting (after ros master or raspberry's ip changed)
Each time roscore is restarted on the master computer, or one of the ips changed, the environment variables should be updated in the docker-compose file.
After that the docker should be restarted.

Change to the directory containing configuration and run:

```sh
cd $RECONCYCLE_CONFIG
docker-compose restart
```

### Upgrading (after changes in the software)
When you make changes to the packages in the raspi docker, you have to stop the service and rebuild the docker.

```sh
cd $RECONCYCLE_CONFIG
docker-compose down

cd ~/raspberry_reconcycle_init
./init_container.sh

cd $RECONCYCLE_CONFIG
docker-compose up
```

## Troubleshooting

### Wrong network setup

Verify the environment variables section of `docker-compose.yaml` in the configuration folder to look like this:

```yaml
    environment:
      - ROS_MASTER_URI=http://10.20.0.1:11311
      - ROS_IP=10.20.1.XXX
      - THIS_RAS_NAME='example'
```

Check [network setup](http://wiki.ros.org/ROS/NetworkSetup) if you encounter the AF_INET error!

### Unsynchronized time

Set correct NTP

```bash
sudo apt-get install ntp ntpdate
sudo service ntp stop
sudo ntpdate goodtime.ijs.si
sudo service ntp start
sudo timedatectl set-timezone Europe/Ljubljana
```


