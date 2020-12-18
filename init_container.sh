
echo "load and run docker package"

# build the docker image
cd $HOME
git clone https://github.com/ReconCycle/raspi-reconcycle-docker.git
cd raspi-reconcycle-docker
docker build -t raspi:active .




# setup automatic start of docker container (--restart on-failure )

docker run -d -v $HOME/reconcycle_config/:/reconcycle_config/ --net=host --device /dev/mem --privileged --name ros1_active raspi:active
