#! /bin/bash
set -eu

# path
DIR=$(dirname $0)
CONNPASS_API_SEARCH=${DIR}/api-shell-scripts/src/search.sh
DB_API=${DIR}/db/api.sh

# wait for db launch
/bin/bash ${DB_API} wait

# search param
keyword_or=福岡,fukuoka
address_matcher='福岡|北九州|fukuoka'
max_count=100

# interval[sec]
INTERVAL=600

search () {
    echo "search start : $(date)"

    # search
    events=$(/bin/bash ${CONNPASS_API_SEARCH} ${keyword_or} ${address_matcher} ${max_count})
    #echo ${events} | jq -s .
    
    len=$(echo $events | jq -s '. | length')
    for i in $( seq 0 $(($len - 1)) ); do
        event=$(echo $events | jq -s .[$i])
        echo ${event} | jq -r '. | (.event_id | tostring) + " | " + .started_at + " | " + .title + " | " + .address+ " | " + .event_url'
        
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

while true;
do
    search
    sleep ${INTERVAL}
done
