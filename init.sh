#!/bin/bash

set -e

# Wire repos to home directory
#ln -s $CODER_DIR/repos ~/project/repos

if [ ! -z "$CF_API" ]; then
  # Log in to CF CLI
  cf login -a $CF_API -u $WORKSHOP_ID -p $CF_PASSWORD --skip-ssl-validation
fi
