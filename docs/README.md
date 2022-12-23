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
