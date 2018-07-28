#!/bin/sh

echo "stoping containers..."
docker-compose stop
echo "removing containers..."
docker-compose rm
