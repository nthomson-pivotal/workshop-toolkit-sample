#!/bin/bash

set -e

sudo apt-get update -y

# Packages
sudo apt-get install -y openjdk-8-jdk git

# Fetch spring-music
git clone https://github.com/cloudfoundry-samples/spring-music.git

# Link CF executable
sudo ln -s /mnt/coder/bin/cf /usr/bin/cf

# Log in to CF CLI
#cf login -a $cf_api -u admin -p $cf_password --skip-ssl-validation