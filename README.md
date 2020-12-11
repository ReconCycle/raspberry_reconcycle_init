# raspberry_reconcycle_init
This repository contains the shell script and files required to automatically set up Raspberry for reconcycle project.

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
