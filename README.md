# Safe Services Main Docker

This repository contains the minimum viable local setup for our backend services.
The setup presented here, assumes that only L2 safes will be used. Additionally, we have tested this setup with the following versions: 

- `CFG_VERSION=v2.5.0`
- `CGW_VERSION=v3.6.0`
- `TXS_VERSION=v3.3.0`

You can change them to the version you are interested available in [docker-hub](https://hub.docker.com/u/gnosispm) but be aware that not all versions of our services are compatible with each other, so do so **at your own risk.** 

## Step 0: docker crash course (optional)

Building and running the whole setup can be done with the following commands: 

```bash
docker compose build --force-rm
docker compose up
```

- Accessing `bash` in your web containers can be achieved by: 

```bash
docker exec -it safe-infrastructure_cfg-web_1 bash
docker exec -it safe-infrastructure_txs-web_1 bash
```

`Ctrl+d` will end interactive mode.

- Accessing `redis-cli` in either redis can be achieved like so"

```bash
docker exec -it safe-infrastructure_redis_1 redis-cli
docker exec -it safe-infrastructure_txs-redis_1 redis-cli
```

- Accessing `postgres`. The Safe Config and Safe transaction services share the same instance

```bash
docker exec -it safe-infrastructure_db_1 psql -U postgres
```

## Step 1: setup your .env

We recommend using what is available in the `.env.sample` file as it contains versions of our services guaranteed to be compatible with each other: 

```bash
cp .env.sample .env
```

Simply, edit your `.env` and set `RPC_NODE_URL` to the chain you want the services running against. 
**Important Note:** Only L2 safes are supported in the setup provided. Change this at your own risk. 


## Step 2: Setup djando superusers

You will need to identify the ID or name of the containers using `docker ps`. To create the default super user for the Safe Config Service, we run the following command:

```bash
docker exec safe-infrastructure_cfg-web_1 python src/manage.py createsuperuser --noinput
```

You can now access http://localhost:8000/cfg/admin/ and login using the credentials `root/admin`.

To achieve the same for the Safe Transaction service: 

```bash
docker exec safe-infrastructure_txs-web_1 python manage.py createsuperuser --noinput
```

Note 1: note that the path to `manage.py` is different. In case you need to run other commands.

Note 2: remember to replace your container ID or name.

## Step 3: Add your `ChainInfo`

We need to be able to define a `ChainInfo` object in the Safe Config service so that the Client Gateway knows the URL of the Safe Transaction service instance it needs to request against for a given safe.

In order to do this, we need to use `manage.py` from the Safe Config serivce. We start an interactive console like so:

```bash
docker exec -it safe-infrastructure_cfg-web_1 bash
```
Once inside the container, you have to define the object in the database. You can find an example for `Rinkeby` in this repository in the file `json/rinkeby.json`.

Now follow these steps:
1. Put the json of your `ChainInfo` in your clipboard (`cmd + c` or `ctrl + c`), you can use the contents of `json/rinkeby.json` if you are setting up for rinkeby. Otherwise, be aware that the field `pk` in the json needs to correspond to the `chain_id`
2. In your terminal where you have `docker exec -it` running paste the following:
```bash
cd src # this is where your "manage.py" file will be located
echo '<the json for your ChainInfo>' > chain.json
python manage.py loaddata chain.json
```
3. Verify that your `ChainInfo` was successfully added by going to `http://localhost:8000/cfg/api/v1/chains`. 

## Step 4: Add your webhooks

//TODO 
