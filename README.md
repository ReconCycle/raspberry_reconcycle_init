# raspberry_reconcycle_init
This repository contains the shell script and files required to automatically set up Raspberry for reconcycle project.

## System setup
Plug board on HDMI display

Install Rasperian or use preinstalled card

Update system 

Enable SSH (main menu -> preferences -> Raspeberry Pi Configurations -> Interfaces -> enable SSH)

Now you can work futher either trough desktop or ssh (sudo ssh pi@x.x.x.x)


## Prepare file system

First clone init repository

```sh
git clone https://github.com/ReconCycle/raspberry_reconcycle_init.git
```

Run init script

```sh
cd raspberry_reconcycle_init/
chmod +x init.sh
./init.sh


```
Run container init script in new terminal

```sh
cd $HOME
chmod +x init_container.sh
./init_container.sh
```

Prepare startup rutine

```sh

sudo nano /etc/rc.local
docker container start ros1_active
```
[//]: # (This may be the most platform independent comment)



## Set up specific raspberry 


```sh
cd $HOME/reconcycle_config/
```

Set name of your tool (this is then the name for ros namespace)
```sh
nano node_name.txt
```

Set ROS_MASTER_URI
```sh
nano master_link.txt
```

Restart raspberry (or docker) for activating new settings 
