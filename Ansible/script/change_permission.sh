#!/bin/bash

cd /home/nfs/ipx/current
chown eclass:eclass -R /home/nfs/ipx/current/*
chown eclass:eclass -R /home/nfs/ipx/current/.*
find . -type f -exec chmod 664 {} \;
find . -type d -exec chmod 775 {} \;
chmod 777 /home/nfs/ipx/current
chmod -R 777 /home/nfs/ipx/current/storage
chmod -R 777 /home/nfs/ipx/current/bootstrap/cache
chmod -R 777 /home/nfs/ipx/current/public
chmod -R 777 /home/nfs/ipx/current/config
mkdir node_modules
chmod -R 777 node_modules
