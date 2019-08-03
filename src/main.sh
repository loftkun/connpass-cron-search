#! /bin/bash
set -eu

# path
DIR=$(dirname $0)
CONNPASS_API_SEARCH=${DIR}/api-shell-scripts/src/search.sh
DB_API=${DIR}/db/api.sh

check_env(){
    if [ ! -v SEARCH_KEYWORD_OR ]; then
      echo "env empty : SEARCH_KEYWORD_OR"
      exit 1
    fi
    if [ ! -v SEARCH_ADDRESS_MATCHER ]; then
      echo "env empty : SEARCH_ADDRESS_MATCHER"
      exit 1
    fi
    if [ ! -v SEARCH_MAX_COUNT ]; then
      echo "env empty : SEARCH_MAX_COUNT"
      exit 1
    fi
    if [ ! -v SEARCH_INTERVAL_SEC ]; then
      echo "env empty : SEARCH_INTERVAL_SEC"
      exit 1
    fi
    if [ ! -v ENABLE_STORE ]; then
      echo "env empty : ENABLE_STORE"
      exit 1
    fi
}

search(){
    echo "search start : $(date)"

    # search
    events=$(/bin/bash ${CONNPASS_API_SEARCH} ${SEARCH_KEYWORD_OR} "${SEARCH_ADDRESS_MATCHER}" ${SEARCH_MAX_COUNT})
    #echo ${events} | jq -s .
    
    len=$(echo $events | jq -s '. | length')
    for i in $( seq 0 $(($len - 1)) ); do
        event=$(echo $events | jq -s .[$i])
        
        if [ ${ENABLE_STORE} == "true" ]; then
          echo ${event} | jq -r '. | (.event_id | tostring) + " | " + .started_at + " | " + .title + " | " + .address+ " | " + .event_url'
        else
          echo ${event} | jq -r -c .
          continue
        fi

        # key : id
        # val : event
        key=$(echo ${event} | jq .event_id)
        val=$(echo ${event} | jq -c -a .)
        val=${val#\"}
        val=${val%\"}

        # check
        # TODO: 日時が新しくなっているなら更新すると更新通知できるけど今は新着通知のみ実施する予定なので不要なので実装していない
        exists=$(/bin/bash ${DB_API} exists ${key})
        echo exists=${exists}
        if [ "${exists}" != "0" ]; then
            continue
        fi

        # store
        #echo "store ${key} : val=${val}"
        /bin/bash ${DB_API} set ${key} "${val}"
    done
    echo "search end   : $(date)"
}

main(){
  check_env

  # check connect to db
  if [ ${ENABLE_STORE} == "true" ]; then
    /bin/bash ${DB_API} check_connect
  fi
  
  while true;
  do
      search
      sleep ${SEARCH_INTERVAL_SEC}
  done
}

main