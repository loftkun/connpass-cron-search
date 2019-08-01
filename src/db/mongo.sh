#! /bin/bash
set -eu

USER=root
PASS=example
HOST=store
DB=connpass

wait_launch() {
  until mongo --eval "db.${DB}.find().count();" admin -u ${USER} -p ${PASS} --host ${HOST} --quiet > /dev/null 2>&1 ; do
    echo "wait for \"${HOST}\" launch..."
    sleep 1
  done
}

check_exists() {
  key=${1}
  mongo --eval "db.${DB}.find({event_id:${1}}).count();" admin -u ${USER} -p ${PASS} --host ${HOST} --quiet
}

set_key_val() {
  key=${1}
  val=${2}
  mongo --eval "db.${DB}.insert(${2});" admin -u ${USER} -p ${PASS} --host ${HOST} --quiet
}

get_key_val() {
  key=${1}
  mongo --eval "db.${DB}.find({event_id:${1}});" admin -u ${USER} -p ${PASS} --host ${HOST} --quiet
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