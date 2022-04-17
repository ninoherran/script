#!/bin/bash

deploy_dir=$1
GREEN='\033[0;32'

function main {
  cd $deploy_dir
  install_container
  install_nginix
}

function install_container {
  docker build --tag fakeapi:latest .
  docker run --name fakeapi -p 8080:80 -p 444:443 -d fakeapi:latest
  printf ">> API Container has been deployed (his name is fakeapi) !"
}

function install_nginix {
  docker run --name nginx -p 80:80 -p 443:443 -d nginx
  printf "${GREEN} === Nginx Container has been deployed !"
}

main
exit 0