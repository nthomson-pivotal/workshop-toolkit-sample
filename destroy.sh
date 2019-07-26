#!/bin/bash

set -e

BIN_DIR=$CODER_DIR/bin

if [ ! -z "$CF_API" ]; then
  $BIN_DIR/cf login -a $CF_API -u admin -p $CF_PASSWORD --skip-ssl-validation -o system

  $BIN_DIR/cf delete-space -o workspaces $WORKSHOP_ID -f

  $BIN_DIR/cf delete-user $WORKSHOP_ID -f
fi
