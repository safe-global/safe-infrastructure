## Safe Services Main Docker

This repository contains the minimum viable local setup for our backend services.

(more details to come)

```bash
cp .env.sample .env
```

Edit `.env` and set `RPC_NODE_URL`. Then:

```bash
docker-compose build --force-rm
docker-compose up
```
