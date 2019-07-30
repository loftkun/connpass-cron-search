#! /bin/bash

REDIS_HOST=store

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
    redis-cli -h redis --raw get ${key}
}

switch_args() {
  SUBCOMMAND=$1
  case "$SUBCOMMAND" in
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