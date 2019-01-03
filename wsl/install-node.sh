#!/bin/bash

sudo apt-get install nodejs-legacy
sudo apt-get install npm
sudo npm install -g n
sudo n lts
sudo npm install npm@lts -g
sudo chown -R $USER:$(id -gn $USER) ~/.config
