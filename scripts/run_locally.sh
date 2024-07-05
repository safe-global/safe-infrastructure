#!/bin/bash

set -e

echo "==> $(date +%H:%M:%S) ==> Starting up environment containers..."
docker compose pull \
  && docker compose down -v \
  && docker compose up -d \
  && echo "==> $(date +%H:%M:%S) ==> Creating super-user for Safe Config Service... (may take a while)" \
  && docker compose exec cfg-web python src/manage.py createsuperuser \
  && echo "==> $(date +%H:%M:%S) ==> Creating super-user for Safe Transaction Service... (may take a while)" \
  && docker compose exec txs-web python manage.py createsuperuser || exit

echo "==> $(date +%H:%M:%S) ==> All set! You may want to add a ChainInfo into the Config service. Please use the link below to fill its data: http://localhost:8000/cfg/admin/chains/chain/add/"
