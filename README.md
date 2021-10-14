## Safe Services Main Docker

This repository contains the minimum viable local setup for our backend services.
The setup presented here, assumes that only L2 safes will be used. Additionally, we have tested this setup with the following versions: 

- `CFG_VERSION=v2.5.0`
- `CGW_VERSION=v3.6.0`
- `TXS_VERSION=v3.3.0`

You can change them to the version you are interested available in [docker-hub](https://hub.docker.com/u/gnosispm) but be aware that not all versions of our services are compatible with each other, so do so **at your own risk.** 

### Step 0: docker refresher (optional)

Building and running the whole setup can be done with the following commands: 

```bash
docker compose build --force-rm
docker compose up
```

### Step 1: setup your .env

We recommend using what is available in the `.env.sample` file as it contains versions of our services guaranteed to be compatible with each other: 

```bash
cp .env.sample .env
```

Simply, edit your `.env` and set `RPC_NODE_URL` to the chain you want the services running against. 
**Important Note:** Only L2 safes are supported in the setup provided. Change this at your own risk. 


### Step 2: Setup djando superusers

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

### Step 3: Add your `ChainInfo`

//TODO 

### Step 4: Add your webhooks

//TODO 
