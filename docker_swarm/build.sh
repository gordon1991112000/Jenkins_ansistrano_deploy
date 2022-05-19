#!/bin/bash

BUILD_PATH=`pwd`

# Check if .env file exists
if [ -e .env ]; then
source .env
else
  echo "Please copy the .env.example file to .env and fill it with correct values."
  exit 1
fi

if [ ! -d "data/mysql" ]; then
  mkdir -p data/mysql
fi

if [ -f "$BUILD_PATH/data/mysql/.gitkeep" ];then
    rm $BUILD_PATH/data/mysql/.gitkeep
fi

echo "Project name   : $COMPOSE_PROJECT_NAME"
echo "Project folder： $PROJECT_ROOT"

PROJECT_FOLDER="$PROJECT_ROOT"
if [ -d "$PROJECT_FOLDER" ]; then
  echo "Project folder exist!"
else
  echo "Creating new project folder and index.php page"
  mkdir -p $COMPOSE_PROJECT_NAME/public
  mv $COMPOSE_PROJECT_NAME ../
  cp -rpf demo.php ../$COMPOSE_PROJECT_NAME/public/index.php
fi

sed -i -e "s/MYSQL_PASSWORD/$MYSQL_ROOT_PASSWORD/g" ../$COMPOSE_PROJECT_NAME/public/index.php

docker-compose up -d --remove-orphans
