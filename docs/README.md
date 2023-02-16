# Safe Infrastructure

## Requirements

- `docker compose` (installation [guide](https://docs.docker.com/compose/install/))

## Pinned versions

This repository contains the minimum viable local setup for our backend services.
The setup presented here, assumes that only L2 safes will be used. Additionally, we have tested this setup with the following versions:

- `CFG_VERSION=v2.26.0`
- `CGW_VERSION=v3.29.0`
- `TXS_VERSION=v4.6.1`
- `UI_VERSION=v1.2.0`

You can change them to the version you are interested available in [docker-hub](https://hub.docker.com/u/safeglobal) but be aware that not all versions of our services are compatible with each other, so do so **at your own risk.**

- [Brief Docker Crash Course](docker_cheatsheet.md)
- [Guide to run our services locally](running_locally.md)

## Minimum Requirements

For **Transaction Service** we have the next requirements:
- Network Mainnet :
	- Tx Service:
		- CPU: 8 vCPU
		- RAM: 32 GiB
	- Database Service:
		- CPU:  8 cores / 16 vCPU
		- RAM: 64 GiB
- Network Polygon :
	- Tx Service:
		- CPU: 4 vCPU
		- RAM: 16 GiB
	- Database Service:
		- CPU: 2 cores / 4 vCPU
		- RAM: 16 GiB
- Network Gnosis-Chain :
	- Tx Service:
		- CPU: 4 vCPU
		- RAM: 16 GiB
	- Database Service:
		- CPU: 2 core / 4 vCPU
		- RAM: 16 GiB
- Network Goerli :
	- Tx Service:
		- CPU: 4 vCPU
		- RAM: 16 GiB
	- Database Service:
		- CPU: 1 core / 2 vCPU
		- RAM: 8 GiB

For **Client Gateway** we have the next requirements:
- CPU: 2 vCPU
- RAM: 8 GiB

For **Config Service** we have the next requirements:
- Config Service:
	- CPU: 2 vCPU
	-  RAM: 8 GiB
- Database Config Service:
	- CPU: 1 core / 2 vCPU
	- RAM: 8 GiB
