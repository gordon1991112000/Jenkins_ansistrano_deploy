#!/bin/bash

cd /home/web/

if [[ -d demo ]]
then
    echo "Demo project exist! 88"
else
{
    composer create-project laravel/laravel:8 demo 8
    cd demo 
    chmod 777 storage -R
}
fi