#!/bin/bash

# Create the directory if it does not exist
mkdir -p container_env_files

# Check for required environment variables
if [ -z "${CONFIG_DOMAIN}" ]
then
  echo CONFIG_DOMAIN env is missing
  exit 1
fi

if [ -z "${RPC_NODE_URL}" ]
then
  echo RPC_NODE_URL env is missing
  exit 1
fi

# Generate the environment files using `sed`
sed "s|{RPC_NODE_URL}|$RPC_NODE_URL|g;" $1 ./container_env_files_templates/.env > .env

sed "s|{CONFIG_DOMAIN}|$CONFIG_DOMAIN|g;" $1 ./container_env_files_templates/cfg.env > ./container_env_files/cfg.env

cp ./container_env_files_templates/cgw.env ./container_env_files/cgw.env

cp ./container_env_files_templates/events.env ./container_env_files/events.env

sed "s|{CONFIG_DOMAIN}|$CONFIG_DOMAIN|g;" $1 ./container_env_files_templates/txs.env > ./container_env_files/txs.env

sed "s|{CONFIG_DOMAIN}|$CONFIG_DOMAIN|g;" $1 ./container_env_files_templates/ui.env > ./container_env_files/ui.env



