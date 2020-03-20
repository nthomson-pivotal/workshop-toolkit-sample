#!/bin/bash

set -e

# Create empty repos directory
mkdir ~/project/repos

code-server --install-extension redhat.java
code-server --install-extension vscjava.vscode-spring-initializr
code-server --install-extension vscjava.vscode-maven
code-server --install-extension vscjava.vscode-java-test

if [ ! -z "$CF_API" ]; then
  # Log in to CF CLI
  cf login -a $CF_API -u $WORKSHOP_ID -p $CF_PASSWORD --skip-ssl-validation
fi
