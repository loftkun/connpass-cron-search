#! /bin/bash
set -eu

CONTAINER=connpasscronsearch_search_1
HOST=store

# set
sudo docker exec -it ${CONTAINER} redis-cli -h ${HOST} set testkey testval

# get
sudo docker exec -it ${CONTAINER} redis-cli -h ${HOST} get testkey

# get json
sudo docker exec -it ${CONTAINER}  redis-cli -h ${HOST} --raw get 138014 | jq .

# delete all keys
#sudo docker exec -it ${CONTAINER}  redis-cli -h ${HOST} FLUSHALL