#! /bin/bash

CONTAINER=connpasscronsearch_search_1

# set
sudo docker exec -it ${CONTAINER} redis-cli set testkey testval

# get
sudo docker exec -it ${CONTAINER} redis-cli get testkey

# get json
sudo docker exec -it ${CONTAINER}  redis-cli -h redis --raw get 137039 | jq ' . | fromjson | .event_url '

# delete all keys
#sudo docker exec -it ${CONTAINER}  redis-cli -h redis FLUSHALL