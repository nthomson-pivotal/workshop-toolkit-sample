#!/bin/bash

set -e

BIN_DIR=$CODER_DIR/bin

mkdir -p $BIN_DIR

if [ ! -f "$BIN_DIR/cf" ]; then
  wget -O /tmp/cf.tgz https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v6.46.0/cf-cli_6.46.0_linux_x86-64.tgz

  tar -zxf /tmp/cf.tgz cf

  mv cf $BIN_DIR/cf

  chmod +x $BIN_DIR/cf
fi

$BIN_DIR/cf login -a $CF_API -u admin -p $CF_PASSWORD --skip-ssl-validation