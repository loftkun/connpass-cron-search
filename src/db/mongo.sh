#! /bin/bash
set -eu

HOST=store
PORT=27017
DB=connpass-db
USER=connpass-user
PASS=1234
COLLECTION=events

wait_launch() {
  until mongo --eval "db.${COLLECTION}.find().count();" ${HOST}:${PORT}/${DB} -u ${USER} -p ${PASS} --quiet > /dev/null 2>&1 ; do
    echo "wait for \"${HOST}\" launch..."
    sleep 1
  done
}

check_exists() {
  key=${1}
  mongo --eval "db.${COLLECTION}.find({event_id:${1}}).count();" ${HOST}:${PORT}/${DB} -u ${USER} -p ${PASS} --quiet
}

set_key_val() {
  key=${1}
  val=${2}
  mongo --eval "db.${COLLECTION}.insert(${2});" ${HOST}:${PORT}/${DB} -u ${USER} -p ${PASS} --quiet
}

get_key_val() {
  key=${1}
  mongo --eval "db.${COLLECTION}.find({event_id:${1}});" ${HOST}:${PORT}/${DB} -u ${USER} -p ${PASS} --quiet
}

switch_args() {
  SUBCOMMAND=$1
  case "$SUBCOMMAND" in
    "wait" )
      shift
      wait_launch $@
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

switch_args "$@"