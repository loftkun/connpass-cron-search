#! /bin/bash
set -eu

# for mongo init ( /docker-entrypoint-initdb.d/*.js )
sudo rm volumes/mongo/db* -rf

# launch
sudo docker-compose up --build
