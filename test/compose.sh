#! /bin/bash
set -eu

# for mongo init ( /docker-entrypoint-initdb.d/*.js )
sudo rm volumes/mongo/db* -rf

# launch
sudo docker-compose up --build

# launch standalone
#sudo docker run -d \
#    --name connpass-cron-search \
#    --network connpasscronsearch_default \
#    -e SEARCH_KEYWORD_OR="沖縄,okinawa" \
#    -e SEARCH_ADDRESS_MATCHER="沖縄" \
#    -e SEARCH_MAX_COUNT=3 \
#    -e SEARCH_INTERVAL_SEC=10 \
#    -e MONGO_HOST=store \
#    -e MONGO_PORT=27017 \
#    -e MONGO_DB=connpass-db \
#    -e MONGO_USER=connpass-user \
#    -e MONGO_PASS=1234 \
#    -e MONGO_COLLECTION=events \
#    loftkun/connpass-cron-search:latest