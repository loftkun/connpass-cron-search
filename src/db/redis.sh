#! /bin/bash
set -eu

REDIS_HOST=store

wait_launch() {
  until redis-cli -h ${REDIS_HOST} --raw set wait_launch 1 > /dev/null 2>&1 ; do
    echo "wait for \"${HOST}\" launch..."
    sleep 1
  done
}

check_exists() {
    key=${1}
    #echo "check_exists : redis-cli -h ${REDIS_HOST} exists ${key}"
    redis-cli -h ${REDIS_HOST} exists ${key}
}

set_key_val() {
    key=${1}
    val=${2}
    #echo "set_key_val : redis-cli -h ${REDIS_HOST} --raw set ${key} "${val}""
    redis-cli -h ${REDIS_HOST} --raw set ${key} "${val}"
}

get_key_val() {
    key=${1}
    redis-cli -h ${REDIS_HOST} --raw get ${key}
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