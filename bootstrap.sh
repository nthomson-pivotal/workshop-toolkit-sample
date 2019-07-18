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

$BIN_DIR/cf login -a $CF_API -u admin -p $CF_PASSWORD --skip-ssl-validation -o system

$BIN_DIR/cf create-space -o workspaces $WORKSHOP_ID

password='pa55w0rd'

$BIN_DIR/cf create-user $WORKSHOP_ID $password
$BIN_DIR/cf set-space-role $WORKSHOP_ID workspaces $WORKSHOP_ID SpaceDeveloper

secret_api=$(echo $CF_API | base64)
secret_password=$(echo $password | base64)

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: $WORKSHOP_ID-cf
  namespace: workspaces
type: Opaque
data:
  cf_api: $secret_api
  cf_password: $secret_password
EOF