#!/bin/bash

GREEN='\033[0;32'

function main {
  install_requirement
  add_docker_gpg_key
  add_to_package_repository
  install_docker
  create_docker_group
  add_user_to_docker_group
  install_dotnet
  
  printf ">> Required package and Docker has been installed"
}


function install_requirement {
  sudo apt update
  sudo apt install -y ca-certificates \
                   rsync \
                   curl \
                   gnupg \
                   lsb-release \
                   postgresql-client
}

function add_docker_gpg_key {
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
}

function add_to_package_repository {
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

function install_docker {
  sudo apt update
  sudo apt install -y docker-ce \
                      docker-ce-cli \
                      containerd.io
}

function create_docker_group {
  sudo groupadd docker
}

function add_user_to_docker_group {
  sudo usermod -aG docker $USER
}

function install_dotnet {
  wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  sudo apt install -y apt-transport-https
  sudo apt-get install -y dotnet-sdk-6.0 aspnetcore-runtime-6.0
}

main
exit 0