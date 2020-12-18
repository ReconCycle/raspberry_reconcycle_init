# raspberry_reconcycle_init
This repository contains the shell script and files required to automatically set up Raspberry for reconcycle project.

## System setup
Plug board on HDMI display

Install Rasperian or use preinstalled card

Update system 

Enable SSH (main menu -> preferences -> Raspeberry Pi Configurations -> Interfaces -> enable SSH)

Reboot the system!

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
cd $HOME/raspberry_reconcycle_init/
chmod +x init_container.sh
./init_container.sh
```

Prepare startup rutine with crontab

Open
```sh

crontab -e

```

Copy this in file and set that 60 seconds after reboot runs the docker
```bash

@reboot sleep 60 && docker container restart ros1_active  && echo "restarting docker" | wall

```




## Set up specific raspberry 


```sh
cd $HOME/reconcycle_config/
```

Set name of your tool (this is then the name for ros namespace). 

Open the folowing file in editor and write the name that you chose
```sh
nano node_name.txt
```

Set ROS_MASTER_URI

Open the folowing file in editor and correct to the IP of computer that will run your ROS master
```sh
nano master_link.txt
```

Restart raspberry (or docker) for activating new settings 

[CHECK](http://wiki.ros.org/ROS/NetworkSetup) network configuration if AF_INET error!


## Update (when you make changes to the packages building the raspi docker) 

```sh
docker container stop ros1_active
docker container rm ros1_active
cd $HOME/raspi_reconcycle_docker
docker image rm raspi:active
docker build -t raspi:active .
docker run -d -v $HOME/reconcycle_config/:/reconcycle_config/ --net=host --device /dev/mem --privileged --name ros1_active raspi:active
```

