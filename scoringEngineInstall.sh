#!/bin/bash

#This script should execute and build all
#the neccsary parts for gettingt he scoring engine running.

#Installing Required Programs
sudo apt-get update
sudo apt-get install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	lsb-release \
	make

#Docker Engine Installation
#set up the gpg
curl  -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
	"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Installing the docker engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
#confirm it all works
sudo docker run hello-world

#installing docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

#get the lastest scoring engine
curl https://github.com/scoringengine/scoringengine/archive/refs/heads/master.zip -L -o scoringEngine.zip

unzip scoringEngine.zip

cd scoringengine-master
sudo docker-compose build
sudo make rebuild-new
