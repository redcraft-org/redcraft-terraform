#!/bin/bash

set -e

terraform init -backend-config "access_key=$SCW_ACCESS_KEY" -backend-config "secret_key=$SCW_SECRET_KEY"
