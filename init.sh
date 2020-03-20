#!/bin/bash

set -e

# Create empty repos directory
mkdir ~/project/repos

# OS packages
RUN apt-get update && apt-get install --no-install-recommends -y \
    default-jre-headless \
    default-jdk-headless \
    maven \
    gradle

# Extensions
code-server --install-extension redhat.java
code-server --install-extension vscjava.vscode-spring-initializr
code-server --install-extension vscjava.vscode-maven
code-server --install-extension vscjava.vscode-java-test
code-server --install-extension ecmel.vscode-spring-boot
code-server --install-extension vscjava.vscode-spring-boot-dashboard

if [ ! -z "$CF_API" ]; then
  # Log in to CF CLI
  cf login -a $CF_API -u $WORKSHOP_ID -p $CF_PASSWORD --skip-ssl-validation
fi
