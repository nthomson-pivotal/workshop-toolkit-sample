#!/bin/bash

set -e

# Fetch spring-petclinic
git clone https://github.com/spring-projects/spring-petclinic.git

if [ ! -z "$CF_API" ]; then
  # Log in to CF CLI
  cf login -a $CF_API -u $WORKSHOP_ID -p $CF_PASSWORD --skip-ssl-validation
fi
