#! /bin/bash
set -eu

DIR=$(dirname $0)

#DB=${DIR}/redis.sh
DB=${DIR}/mongo.sh

/bin/bash ${DB} "$@"


