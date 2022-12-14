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
docker compose exec -it cfg-web bash
docker compose exec -it txs-web bash
```

`Ctrl+d` will end interactive mode.

## Starting redis-cli connected to a container
Accessing `redis-cli` in either redis can be achieved like so"

```bash
docker compose exec -it cgw-redis redis-cli
docker compose exec -it txs-redis redis-cli
```

## Starting psql connected to a container
Accessing `postgres`. The Safe Config and Safe transaction services use the different instance

```bash
docker compose exec -it cfg-db psql -U postgres
docker compose exec -it txs-db psql -U postgres
```