#!/bin/bash

set -e

# Fetch spring-petclinic
git clone https://github.com/spring-projects/spring-petclinic.git

if [ -f /mnt/coder/bashrc.d/cf.bashrc ]; then
  source /mnt/coder/bashrc.d/cf.bashrc
fi

if [ ! -z "$CF_API" ]; then
  # Log in to CF CLI
  /mnt/coder/bin/cf login -a $CF_API -u $WORKSHOP_ID -p $CF_PASSWORD --skip-ssl-validation
fi
