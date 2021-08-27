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
cd
git clone https://github.com/ReconCycle/raspberry_reconcycle_init.git
```

Run the initialisation script to install docker configuration and create the required folders

```sh
cd ~/raspberry_reconcycle_init
chmod +x init.sh
./init.sh
```

In a new terminal run container init script for preparing Docker image (from https://github.com/ReconCycle/raspi-reconcycle-docker)

```sh
cd ~/raspberry_reconcycle_init/
chmod +x init_container.sh
./init_container.sh
```

## Set up the specific raspberry 

Copy the docker-compose.yaml template and edit it.
```sh
cd raspi-reconcycle-docker
cp docker-compose-template.yaml ~/reconcycle_config/docker-compose.yaml
nano ~/reconcycle_config/docker-compose.yaml
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

Check [network setup](http://wiki.ros.org/ROS/NetworkSetup) if you encounter the AF_INET error!

## Start docker-compose service

You're all set. Start the docker with:

```sh
cd ~/raspberry_config/
docker-compose up -d
```

### Restarting (after ros master or raspberry's ip changed)
Each time roscore is restarted on the master computer, or one of the ips changed, the environment variables should be updated in the docker-compose file.
After that the docker should be restarted with:

```sh
cd ~/raspberry_config/
docker-compose restart
```

### Upgrading (after changes in the software)
When you make changes to the packages in the raspi docker, you have to stop the service and rebuild the docker.

```sh
cd ~/raspberry_config/
docker-compose down
cd ~/raspberry_reconcycle_init
./init_container.sh
docker-compose restart
```

## Troubleshooting

### Set correct NTP

```bash
sudo apt-get install ntp ntpdate
sudo service ntp stop
sudo ntpdate goodtime.ijs.si
sudo service ntp start
sudo timedatectl set-timezone Europe/Ljubljana
```


