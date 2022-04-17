#!/bin/bash

user=root
server=164.90.192.28
path_to_ssh_key=~/.ssh/ninoherran.studio
deploy_dir=/root/pandora_api

function main {
    ssh -i $path_to_ssh_key $user@$server 'bash -s' < ./script/install_requirement.sh
    setup_database
    bundle_api
    publish
}

function setup_database {
   ssh -i $path_to_ssh_key $user@$server 'docker run --name postgres -p 5432:5432 -d -e POSTGRES_PASSWORD=test postgres'
  ./script/migrate_database.sh $server
}

function bundle_api {
  cd FakeApi
  dotnet publish -c Release -o dist
  cp Dockerfile dist/
}

function publish {
  scp -r -p -i $path_to_ssh_key dist/ $user@$server:$deploy_dir
  ssh -i $path_to_ssh_key $user@$server 'bash -s' < ../script/install_deployment.sh "$deploy_dir"
}

main
exit 0