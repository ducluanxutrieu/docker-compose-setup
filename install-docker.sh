#!/bin/bash
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y
sudo apt install curl -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo mkdir /srv/nexus
sudo chmod 600 /srv/nexus

export GITLAB_HOME=/srv/gitlab

sudo sysctl -w vm.max_map_count=262144
sudo echo "vm.max_map_count = 262144" >> /etc/sysctl.conf
sudo docker-compose up -d
git clone https://github.com/DevOps01MoocProject/PartyWebServer.git
cd PartyWebServer
sudo docker build -t ducluanxutrieu/node_party_web_server .
sudo docker run -p 49160:3005 -d ducluanxutrieu/node_party_web_server
