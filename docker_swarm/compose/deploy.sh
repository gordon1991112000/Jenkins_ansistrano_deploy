#!/bin/bash

cd ../../ipx/releases/
latest_release=`ls -td -- */ | head -n 1`
cd ../../ecdock/compose
sed -i "/PROJECT_ROOT/s|releases.*|releases\/${latest_release}|" ".env.ipx"
set -a && . .env.ipx && set +a && docker stack deploy --compose-file ipx.yml ecdock
