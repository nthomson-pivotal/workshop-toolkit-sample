#!/bin/bash

set -e

BIN_DIR=$CODER_DIR/bin

sudo apt-get update && sudo apt install -y \
    default-jre-headless \
    default-jdk-headless

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
else
  cat << EOF > /mnt/coder/bashrc.d/cf.bashrc
echo "WARNING: CF CLI not logged in as administrator did not complete setup"
EOF
fi

chmod +x /mnt/coder/bashrc.d/cf.bashrc

repo="https://github.com/cloudfoundry-samples/spring-music.git"

if [ ! -z "$WORKSHOP_REPO" ]; then
  repo="$WORKSHOP_REPO"
fi

REPOS_DIR=$CODER_DIR/repos

mkdir -p $REPOS_DIR

if [ ! -f $REPOS_DIR/README.md ]; then
  git clone $repo $REPOS_DIR
fi
