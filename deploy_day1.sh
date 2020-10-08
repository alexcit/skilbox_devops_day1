#!/bin/bash
# This is script for deploy skilbox_hometask_1day
sudo apt-get update
sudo apt-get install -y docker.io
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
sudo gpasswd -a "$USER"  docker
docker pull node
git clone https://github.com/timurb/flatris.git
cd ./flatris
echo 'FROM node

RUN mkdir /skillbox
COPY package.json /skillbox
WORKDIR /skillbox
RUN yarn install

COPY . /skillbox
RUN yarn test
RUN yarn build

CMD yarn start

EXPOSE 3000
' > Dockerfile

echo 'version: "3"

services:
  skillbox:
    build: .
    ports:
    - "3000:3000"
' > docker-compose.yml
docker-compose up -d
