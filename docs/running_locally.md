# Running our services locally

## Step 1: setup your `.env`

We recommend using what is available in the `.env.sample` file as it contains versions of our services guaranteed to be compatible with each other:

```bash
cp .env.sample .env
```

Simply, edit your `.env` and set `RPC_NODE_URL` to the chain you want the services running against.
**Important Note:** Only L2 safes are supported in the setup provided. Change this at your own risk.

Now you should be able to run

```bash
docker compose up
```

## Step 2: Setup djando superusers

You will need to identify the ID or name of the containers using `docker ps`. To create the default super user for the Safe Config Service, we run the following command:

```bash
docker exec safe-infrastructure-cfg-web-1 python src/manage.py createsuperuser --noinput
```

and then

```bash
docker exec safe-infrastructure-cfg-web-1 python src/manage.py addstatictoken root
```
You can now access http://localhost:8000/cfg/admin/ and login using the credentials `root/admin`.

To achieve the same for the Safe Transaction service:

```bash
docker exec safe-infrastructure-txs-web-1 python manage.py createsuperuser --noinput --username root
```

Note 1: note that the path to `manage.py` is different. In case you need to run other commands.

Note 2: remember to replace your container ID or name.

## Step 3: Add your `ChainInfo`

We need to be able to define a `ChainInfo` object in the Safe Config service so that the Client Gateway knows the URL of the Safe Transaction service instance it needs to request against for a given safe.

You can do this in the admin interface of the Safe Config service: `http://localhost:8000/cfg/admin/chains/chain/add/`

You can verify that your `ChainInfo` was successfully added by going to `http://localhost:8000/cfg/api/v1/chains`.

Remember to edit your `ChainInfo` json fields `transaction_service_uri` and `vpc_transaction_service_uri` to point to your local instance of the transaction service. The values should be `http://nginx:8000/txs`

Check this [section](chain_info.md) for a more complete guide on the fields for `ChainInfo`.

## Step 4: Add your webhooks

Our services invalidate the caches of the client gateway using webhooks. Both the Config and Transaction service need to be configured. For the Config service, unless you've changed the values in `cgw.env` and `cfg.env` then you don't need to do anything, otherwise:

```bash

# Inside the file "container_env_files/cfg.env"
#...
CGW_URL=http://nginx:8000/cgw
CGW_FLUSH_TOKEN=some_random_token

# Inside the file "container_env_files/cgw.env"
WEBHOOK_TOKEN=some_random_token
```

`WEBHOOK_TOKEN` and `CGW_FLUSH_TOKEN` must be the same.

For the Transactions service open a terminal in the container:

```bash
docker exec -it safe-infrastructure_txs-web_1 bash
```

Then use `manage.py` and the custom command for adding a webhook like so:

```bash
python manage.py add_webhook --url=http://nginx:8000/cgw/v1/hook/update/some_random_token
```
### Accessing the Safe Web App

The Gnosis Safe Web App will be available at at http://localhost:8080. Port can be configured on `.env` by modifying `REVERSE_PROXY_UI_PORT`

