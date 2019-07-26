#!/bin/bash

set -e

BIN_DIR=$CODER_DIR/bin

wget -O jdk.tar.gz https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u222-b10/OpenJDK8U-jdk_x64_linux_hotspot_8u222b10.tar.gz

tar -xf jdk.tar.gz -C $CODER_DIR

cat << EOF > /mnt/coder/bashrc.d/jdk.bashrc
export PATH=$PATH:/mnt/coder/jdk8u222-b10/bin
EOF
chmod +x /mnt/coder/bashrc.d/jdk.bashrc

if [ ! -f "$BIN_DIR/cf" ]; then
  wget -O /tmp/cf.tgz https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v6.46.0/cf-cli_6.46.0_linux_x86-64.tgz

  tar -zxf /tmp/cf.tgz cf

  mv cf $BIN_DIR/cf

  chmod +x $BIN_DIR/cf
fi

if [ ! -z "$CF_API" ]; then
  $BIN_DIR/cf login -a $CF_API -u admin -p $CF_PASSWORD --skip-ssl-validation -o system

  $BIN_DIR/cf create-space -o workspaces $WORKSHOP_ID

  password=$(pwgen 8 1)

  $BIN_DIR/cf create-user $WORKSHOP_ID $password
  $BIN_DIR/cf set-space-role $WORKSHOP_ID workspaces $WORKSHOP_ID SpaceDeveloper

  cat << EOF > /mnt/coder/bashrc.d/cf.bashrc
  export CF_API=$CF_API
  export CF_PASSWORD=$password
  EOF

  chmod +x /mnt/coder/bashrc.d/cf.bashrc
  EOF
fi
