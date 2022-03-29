# Heroku deployment guide

This guide operates under the assumption that you have a [Heroku](https://www.heroku.com/) account. This guide borrows heavily from this [article](https://betterprogramming.pub/how-to-containerize-and-deploy-apps-with-docker-and-heroku-b1c49e5bc070) and this documentation [page](https://devcenter.heroku.com/articles/local-development-with-docker-compose)

## Step 1: Login to your Heroku

The following steps are required for login into your account

```bash
heroku login
```

And then 
```bash
heroku container:login
```

## Step 2: Deploy your Safe Transaction Service instance

After your have created an app in `Heroku` (for the sake of this example we've called it `safe-infra`), verify that the local setup and containers are built and run locally, following the [local setup guide](running_locally.md).

Then run the following command

```bash
heroku create
```

Take note of the returned app name, as it will me necessary later. Then run

And to push your locally built image, run

```bash
heroku container:push txs-web
```