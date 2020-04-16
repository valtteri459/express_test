#!/bin/bash
sudo docker build -t localtest:latest -t localtest:$(sed 's/.*"version": "\(.*\)".*/\1/;t;d' package.json) .;
CID=$(sudo docker ps -q -f name=^/localtest)
if [ ! "${CID}" ]; then
  echo "Container doesn't exist, no need to shut down and delete"
else
  sudo docker stop localtest
  sudo docker rm localtest
fi
unset CID
sudo docker run --name localtest -d localtest:latest
