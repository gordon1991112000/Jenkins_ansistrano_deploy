#!/bin/bash

docker -H ssh://root@10.0.80.84:2022 exec -i $(docker -H ssh://root@10.0.80.84:2022 ps | grep ecdock_php80 | awk '{print $1}') bash -c 'cd /home/web && php artisan horizon:terminate --domain=ipx-demo.eclasscloud.hk'
