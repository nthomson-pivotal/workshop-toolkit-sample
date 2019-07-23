#!/bin/bash

set -e

# Fetch spring-music
git clone https://github.com/cloudfoundry-samples/spring-music.git

source /mnt/coder/bashrc.d/cf.bashrc

# Log in to CF CLI
/mnt/coder/bin/cf login -a $CF_API -u $WORKSHOP_ID -p $CF_PASSWORD --skip-ssl-validation
