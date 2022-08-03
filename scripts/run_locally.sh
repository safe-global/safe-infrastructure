#!/bin/bash

echo "==> $(date +%H:%M:%S) ==> Setting up environment variables from sample file..."
TEMP=temp.env
cp ../.env.sample $TEMP

echo "==> $(date +%H:%M:%S) ==> Using http://polygon-rpc.com as default RPC node"
sed -i '' 's|http://url.to.node|https://polygon-rpc.com|g' $TEMP
mv $TEMP ../.env

echo "==> $(date +%H:%M:%S) ==> Starting up environment containers..."
docker compose up -d \
  && echo "==> $(date +%H:%M:%S) ==> Creating super-user for Safe Config Service..." \
  && docker compose exec cfg-web python src/manage.py createsuperuser \
  && echo "==> $(date +%H:%M:%S) ==> Creating super-user for Safe Transaction Service..." \
  && docker compose exec txs-web python manage.py createsuperuser

echo "==> $(date +%H:%M:%S) ==> Adding ChainInfo..."
