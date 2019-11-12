#!/bin/bash

set -e

# Wire repos to home directory
ln -s $CODER_DIR/repos ~/project/repos

if [ ! -z "$CF_API" ]; then
  # Log in to CF CLI
  cf login -a $CF_API -u $WORKSHOP_ID -p $CF_PASSWORD --skip-ssl-validation
fi

# Setup Java Extension
mkdir -p ${EXTENSIONS_DIR}/java \
    && curl -JLs https://marketplace.visualstudio.com/_apis/public/gallery/publishers/redhat/vsextensions/java/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/java extension

mkdir -p ${EXTENSIONS_DIR}/java-debugger \
    && curl -JLs https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-java-debug/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/java-debugger extension

mkdir -p ${EXTENSIONS_DIR}/java-test \
    && curl -JLs https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-java-test/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/java-test extension

mkdir -p ${EXTENSIONS_DIR}/maven \
    && curl -JLs https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-maven/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${VSCODE_EXTENSIONS}/maven extension
