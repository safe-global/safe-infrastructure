# Running our services for production

## Requirements

### Tx Service

| Network 		| Tx Service 					| Database |
| -------		| ---------- 					| -------- |
| Mainnet		| CPU: 8 vCPU<br />RAM: 32GiB	| CPU: 8 cores/ 16 vCPU<br />RAM: 64GiB |
| Polygon		| CPU: 4 vCPU<br />RAM: 16GiB	| CPU: 2 cores/ 4 vCPU<br />RAM: 16GiB |
| Gnosis Chain	| CPU: 4 vCPU<br />RAM: 16GiB	| CPU: 2 cores/ 4 vCPU<br />RAM: 16GiB |
| Goerli		| CPU: 4 vCPU<br />RAM: 16GiB	| CPU: 1 cores/ 2 vCPU<br />RAM: 8GiB|

### Client Gateway
- CPU: 2 vCPU
- RAM: 8 GiB

### Config Service
- Config Service:
	- CPU: 2 vCPU
	-  RAM: 8 GiB
- Database Config Service:
	- CPU: 1 core / 2 vCPU
	- RAM: 8 GiB


## How to

TBD, in the meantime you can take a look at [Yearn instructions](https://github.com/numan/yearn-gnosis-safe)
