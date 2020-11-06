#!/bin/bash

set -e

if [ "$1" != "" ]; then
    SERVER="$1"
else
    echo "Server name:"
    read SERVER
fi

SERVER_FILE="$SERVER.tfvars"

if [ -f "$SERVER_FILE" ]; then
    terraform init -backend-config "access_key=$SCW_ACCESS_KEY" -backend-config "secret_key=$SCW_SECRET_KEY"
else
    echo "$SERVER_FILE does not exist."
    exit 1
fi