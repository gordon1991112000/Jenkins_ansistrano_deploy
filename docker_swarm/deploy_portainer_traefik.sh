#!/bin/bash

set -a && . .env && set +a && docker stack deploy --with-registry-auth --resolve-image always --compose-file docker-compose.yml ecdock
