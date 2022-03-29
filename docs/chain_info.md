# ChainInfo

## Intro

This correct definition of these objects is instrumental to the correct behaviour of our services and web app.
These objects contain information that coordinates the inter-service communication as well as template URLs that allows the frontend to render links to block explorers correctly. These features will be explained in this doc.

At any point, if you see a value that you are unsure how to supply, just look at what's available in [production](https://safe-config.gnosis.io/api/v1/chains/) and change the values as you see fit.  

These values are meant to be provided in the admin panel `http://localhost:8000/cfg/admin` of the CFG (Safe Config Service)

## Connecting the safe CGW to the Transaction Service (TXS)

The CGW can forward requests to many independently running TXS instances pointing to different chains. The CFG has to keep a registry of every available instance of the TXS. 

In order to achieve this, the CFG has 2 fields:

- `vpc_transaction_service`
- `transaction_service`

We introduce these fields for being able to locally debug our services as a VPC (Virtual Private Cloud) URL has benefits in terms of request/response times. You can toggle the usafe of either URL, in the CGW, but for the purpose of this guide we will simply set these values to the same value:

```json
{
    // ...
    "vpc_transaction_service" : "http://nginx:8000/txs",
    "transaction_service" : "http://nginx:8000/txs",
    // ...
} 
```
## Block explorer URL templates

For the web app to be able to render links correctly you need to supply URLs with templates that the web app will eventually use to build links to block explorers. For the sake of this guide, we will share the values for Etherscan Rinkeby:

```json
{
    // ...
    "address": "https://rinkeby.etherscan.io/address/{{address}}",
    "txHash": "https://rinkeby.etherscan.io/tx/{{txHash}}",
    "api": "https://api-rinkeby.etherscan.io/api?module={{module}}&action={{action}}&address={{address}}&apiKey={{apiKey}}"
    // ...
}
```