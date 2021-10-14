## Safe Services Main Docker

This repository contains the minimum viable local setup for our backend services.
The setup presented here, assumes that only L2 safes will be used. Additionally, we have tested this setup with the following versions: 

- `CFG_VERSION=v2.5.0`
- `CGW_VERSION=v3.6.0`
- `TXS_VERSION=v3.3.0`

You can change them to the version you are interested available in [docker-hub](https://hub.docker.com/u/gnosispm) but be aware that not all versions of our services are compatible with each other, so do so **at your own risk.** 

### Step 0: docker refresher (optional)

Building and running the whole setup can be sdon with the following commands: 

```bash
docker compose build --force-rm
docker compose up
```

### Step 1: setup your .env

We recommend using what is available in the `.env.sample` file as it contains versions of our services guaranteed to be compatible with each other: 

```bash
cp .env.sample .env
```

Simply, edit your `.env` and set `RPC_NODE_URL` to the chain you want the services running agains. **Important Note:** Only L2 safes are supported in the setup provided. Change this at your own risk. 


### Step 2: Setup djando superusers

//TODO 

### Step 3: Add your `ChainInfo`

//TODO 

### Step 4: Add your webhooks

//TODO 
