#!/bin/bash

set -a && . .env.ipx && set +a && docker stack deploy --compose-file ipx.yml ecdock
