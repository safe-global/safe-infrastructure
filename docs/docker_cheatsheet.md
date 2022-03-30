# Docker crash course

## Build the entire setup
Building and running the whole setup can be done with the following commands:

```bash
docker compose up
```

Just to build, once you've pulled the images

```bash
docker compose build --force-rm
```

## Bash access to web container
Accessing `bash` in your web containers can be achieved by:

```bash
docker exec -it safe-infrastructure_cfg-web_1 bash
docker exec -it safe-infrastructure_txs-web_1 bash
```

`Ctrl+d` will end interactive mode.

## Starting redis-cli connected to a container
Accessing `redis-cli` in either redis can be achieved like so"

```bash
docker exec -it safe-infrastructure_cgw-redis_1 redis-cli
docker exec -it safe-infrastructure_txs-redis_1 redis-cli
```

## Starting psql connected to a container
Accessing `postgres`. The Safe Config and Safe transaction services share the same instance

```bash
docker exec -it safe-infrastructure_db_1 psql -U postgres
```