#! /bin/bash
set -eu

check_env(){
  if [ ! -v MONGO_HOST ]; then
    exit 1
  fi
  if [ ! -v MONGO_PORT ]; then
    exit 1
  fi
  if [ ! -v MONGO_DB ]; then
    exit 1
  fi
  if [ ! -v MONGO_USER ]; then
    exit 1
  fi
  if [ ! -v MONGO_PASS ]; then
    exit 1
  fi
  if [ ! -v MONGO_COLLECTION ]; then
    exit 1
  fi
}

eval_js(){
  mongo --eval "${1}" ${MONGO_HOST}:${MONGO_PORT}/${MONGO_DB} -u ${MONGO_USER} -p ${MONGO_PASS} --quiet
}

check_connect() {
  until eval_js "db.${MONGO_COLLECTION}.find().count();" > /dev/null 2>&1 ; do
    echo "establishing database connection to \"${MONGO_HOST}\" ..."
    sleep 5
  done
}

check_exists() {
  key=${1}
  eval_js "db.${MONGO_COLLECTION}.find({event_id:${1}}).count();"
}

set_key_val() {
  key=${1}
  val=${2}
  eval_js "db.${MONGO_COLLECTION}.insert(${2});"
}

get_key_val() {
  key=${1}
  eval_js "db.${MONGO_COLLECTION}.find({event_id:${1}});"
}

switch_args() {
  SUBCOMMAND=$1
  case "$SUBCOMMAND" in
    "check_connect" )
      shift
      check_connect $@
      ;;
    "exists" )
      shift
      check_exists $@
      ;;
    "set" )
      shift
      set_key_val "$@"
      ;;
    "get" )
      shift
      get_key_val "$@"
      ;;
  esac
}

check_env
switch_args "$@"