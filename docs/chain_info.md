# ChainInfo

## Intro

The Chain object represents metadata specific to a chain. Its metadata is crucial to not only have a the correct information displayed to the users (chain name, chain logo, native currency, etc...) but also to communicate with the correct instance of the Safe Transaction Service (Transaction Service URI and VPC Transaction Service URI)

The Chain object also contains data which is used specifically in the context of the Safe Web App and the Safe Mobile apps. This data is used mostly for rendering purposes like currency logo, background colours, etc. This data is required but affect only the visual components of the client application. 

And lastly, the Chain object also contains URL templates that indicate the frontend apps how to parse and compose URLs to block explorers. This will be discussed in more detail later on.

At any point, if you see a value that you are unsure how to supply, just look at what's available in [production](https://safe-config.gnosis.io/api/v1/chains/) and change the values as you see fit.  

These values are meant to be provided in the admin panel `http://localhost:8000/cfg/admin` of the Safe Config Service (CFG)

## Connecting the Safe Client Gateway (CGW) to the Safe Transaction Service (TXS)

The CGW can forward requests to many independently running TXS instances pointing to different chains. The CFG has to keep a registry of every available instance of the TXS. 

In order to achieve this, the CFG has 2 fields:

- `vpc_transaction_service`
- `transaction_service`

These two fields are required, because in a production setup, you would have your services potentically located in the same Virtual Private Cloud (VPC) setup. Then you could go as far as making the TXS private and hide it from requests coming from outside your cluster. 
Should this be the case, you can set the value to `false` of [this](https://github.com/gnosis/safe-client-gateway/blob/6e3fa0d5770d185bb0cbe27185d6b33641143b2e/.env.sample#L37) env var in your CGW `.env` [file](container_env_files/cgw.env). 
For the purpose of this guide we will simply set these values to the same value:

```javascript
{
    // ...
    "vpc_transaction_service" : "http://nginx:8000/txs",
    "transaction_service" : "http://nginx:8000/txs",
    // ...
} 
```
## Block explorer URL templates

For the web app to be able to render links correctly you need to supply URLs with templates that the web app will eventually use to build links to block explorers. For the sake of this guide, we will share the values for Etherscan Rinkeby:

```javascript
{
    // ...
    "address": "https://rinkeby.etherscan.io/address/{{address}}",
    "txHash": "https://rinkeby.etherscan.io/tx/{{txHash}}",
    "api": "https://api-rinkeby.etherscan.io/api?module={{module}}&action={{action}}&address={{address}}&apiKey={{apiKey}}"
    // ...
}
```

The `{{address}}` (Ethereum address `0x` prefixed) and `{{txHash}}` (transaction hash) are markers in the URL acting as placeholders that the Safe web app will use to replace values to construct links to block explorer corresponding to that chain. It is important that you indicate these correctly so links are valid at the moment of rendering.