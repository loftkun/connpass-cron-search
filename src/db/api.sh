#! /bin/bash
DIR=$(dirname $0)

# use redis
REDIS_API=${DIR}/redis.sh
/bin/bash ${REDIS_API} "$@"