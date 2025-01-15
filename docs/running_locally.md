# Running our services locally

## Requirements

- `Docker Compose` (installation [guide](https://docs.docker.com/compose/install/))
- [Brief Docker Crash Course](docker_cheatsheet.md)

**Important Note:** If you followed the guide some time ago, it's recommended to clean the existing data:
- Remove containers: `docker compose down -v`.
- Remove docker volumes: `docker compose rm -f -v`.
- Remove `./data` folder, that holds the database.
- Download last versions of the images: `docker compose pull`

## Step 1: setup your `.env`

We recommend using what is available in the `.env.sample` file:

```bash
cp .env.sample .env
```

Then edit your `.env` and set `RPC_NODE_URL` to the chain you want the services running against.

By default, last stable version will be used for every service.

**Important Note:** Only L2 Safes are supported in the setup provided. Change this at your own risk.

## Step 2: Setup Django superusers

### Option #1 - Automated way

We provide a script to automate this second step, if you want to use it, simply write:

```
cd scripts
sh run_locally.sh
```

### Option #2 - Manual way

Start Docker containers:

```bash
docker compose pull
docker compose down -v
docker compose up
```

You will need to identify the ID or name of the containers using `docker ps`. To create the default super user for the Safe Config Service, we run the following command:

```bash
docker compose exec cfg-web python src/manage.py createsuperuser --noinput
```

You can now access http://localhost:8000/cfg/admin/ and login using the credentials `root/admin`.

To achieve the same for the Safe Transaction service:

```bash
docker compose exec txs-web python manage.py createsuperuser --username root
```

Note 1: note that the path to `manage.py` is different. In case you need to run other commands.

## Step 3: Add your `ChainInfo`

We need to be able to define a `ChainInfo` object in the Safe Config service so that the Client Gateway knows the URL of the Safe Transaction service instance it needs to request against for a given safe.

Check this [section](chain_info.md) for a guide on the fields for `ChainInfo`.

You can do this in the admin interface of the Safe Config service: `http://localhost:8000/cfg/admin/chains/chain/add/`.

You can verify that your `ChainInfo` was successfully added by going to `http://localhost:8000/cfg/api/v1/chains`.

Remember to edit your `ChainInfo` json fields `transaction_service_uri` and `vpc_transaction_service_uri` to point to your local instance of the transaction service. The values should be `http://nginx:8000/txs`

## Step 4: Add your `MasterCopies` and `ProxyFactories`

By default, tx service will auto setup `MasterCopies` and `Proxy Factories` for
[a of networks](https://github.com/safe-global/safe-eth-py/blob/main/gnosis/safe/addresses.py).
If your network is not supported you have to add the addresses manually in http://localhost:8000/txs/admin/

## Step 5: Add your webhooks

Our services invalidate the caches of the client gateway using webhooks. Both the Config and Events service need to be configured. For the Config service, unless you've changed the values in `cgw.env` and `cfg.env` then you don't need to do anything, otherwise:

```bash

# Inside the file "container_env_files/cfg.env"
#...
CGW_URL=http://nginx:8000/cgw
CGW_AUTH_TOKEN=some_random_token

# Inside the file "container_env_files/cgw.env"
AUTH_TOKEN=some_random_token
```

`AUTH_TOKEN` and `CGW_AUTH_TOKEN` must be the same.

For the Events service, follow these steps:

- Access the admin panel at `http://localhost:8000/events/admin`
- Default user and password is defined in `container_env_files/events.env`
- Click on `Webhook` at the left column and then click on `Create new`
- Set the `Url` field to `http://nginx:8000/cgw/v1/hooks/events`
- Set description `CGW`
- Enable `Is Active` field
- Set the `Authorization` field to `Basic <AUTH_TOKEN>`, where `<AUTH_TOKEN>` corresponds to the value of `AUTH_TOKEN` in the `container_env_files/cgw.env` file of this repository
- Leave chains field blank
- Enable every webhook option and click `Save`

# Safe Web App

The Safe Web app will be available at at http://localhost:8000/ although check the output of `docker compose` to see that the container is already running, as in some step-ups, it can take longer than expected ( >15 minutes).

Add your `NEXT_PUBLIC_INFURA_TOKEN` value if its required for the chain RCP uri in the [container_env_files/ui.env](../container_env_files/ui.env) file.

Additionally, the Safe Web app itself, defines which instance of the Safe CGW to use in this [container_env_files/ui.env](../container_env_files/ui.env) file. The value of `NEXT_PUBLIC_GATEWAY_URL_PRODUCTION` defines the URL where the Safe CGW can be reached. The default in this repo, points to the instance running as part of the `docker-compose.yml` file, but can be adjusted to point to our production instances, or your own hosted instance.

## Video tutorial

Not recorded by the Safe team, but [here you can find an example of setting up Avalanche Fuji C-Chain](https://www.youtube.com/watch?v=FUytj_xStDI)
