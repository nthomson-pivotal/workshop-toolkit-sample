#!/bin/bash

set -e

sudo apt-get update && sudo apt-get install --no-install-recommends -y \
    default-jre-headless \
    default-jdk-headless \
    maven \
    gradle

# Fetch spring-petclinic
git clone https://github.com/spring-projects/spring-petclinic.git

if [ ! -z "$CF_API" ]; then
  # Log in to CF CLI
  cf login -a $CF_API -u $WORKSHOP_ID -p $CF_PASSWORD --skip-ssl-validation
fi

mkdir -p ${EXTENSIONS_DIR}/java \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/redhat/vsextensions/java/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${EXTENSIONS_DIR}/java extension
    
mkdir -p ${EXTENSIONS_DIR}/java-debugger \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-java-debug/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${EXTENSIONS_DIR}/java-debugger extension

mkdir -p ${EXTENSIONS_DIR}/java-test \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-java-test/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${EXTENSIONS_DIR}/java-test extension

    
mkdir -p ${EXTENSIONS_DIR}/maven \
    && curl -JLs --retry 5 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/vscjava/vsextensions/vscode-maven/latest/vspackage | bsdtar --strip-components=1 -xf - -C ${EXTENSIONS_DIR}/maven extension
