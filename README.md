# connpass-cron-search

search and store new arrival events of [connpass](https://connpass.com/)

You can find Docker image at [Docker Hub](https://hub.docker.com/r/loftkun/connpass-cron-search).

## usage

### running with docker compose

You can launch with MongoDB and WebUI ([mongo-express](https://github.com/mongo-express/mongo-express))

``` shell
$ docker-compose up
```

You can view `events` collection by visiting `http://localhost:8081/db/connpass-db/events`

### running standalone ( not using DB )

``` shell
$ docker run -d \
    --name connpass-cron-search \
    -e SEARCH_KEYWORD_OR="福岡,fukuoka" \
    -e SEARCH_ADDRESS_MATCHER="福岡|北九州|fukuoka" \
    -e SEARCH_MAX_COUNT=100 \
    -e SEARCH_INTERVAL_SEC=600 \
    -e ENABLE_STORE=false \
    loftkun/connpass-cron-search:1.0
$ docker logs -f connpass-cron-search | tee ./connpass-cron-search.log
```

### running with MongoDB

You can save search results (new arrival events) to MongoDB.

``` shell
$ docker run -d \
    --name connpass-cron-search \
    -e SEARCH_KEYWORD_OR="福岡,fukuoka" \
    -e SEARCH_ADDRESS_MATCHER="福岡|北九州|fukuoka" \
    -e SEARCH_MAX_COUNT=100 \
    -e SEARCH_INTERVAL_SEC=600 \
    -e ENABLE_STORE=true \
    -e MONGO_HOST=store \
    -e MONGO_PORT=27017 \
    -e MONGO_DB=connpass-db \
    -e MONGO_USER=connpass-user \
    -e MONGO_PASS=1234 \
    -e MONGO_COLLECTION=events \
    loftkun/connpass-cron-search:1.0
```

### environment variables

#### search paramas

| param | description | e.g. |
| --- | --- | --- |
| SEARCH_KEYWORD_OR | search keyword<br>(comma separated)| "福岡,fukuoka" | 
| SEARCH_ADDRESS_MATCHER | matcher for address of event | "福岡&#124;北九州&#124;fukuoka" | 
| SEARCH_MAX_COUNT | search num of latest events<br>( if set 0, search all events ) | 100 |
| SEARCH_INTERVAL_SEC | periodical search duration interval[sec] | 600 |

#### db paramas

You can save search results to MongoDB.

| param | description | e.g. |
| --- | --- | --- |
| ENABLE_STORE | if true, save search results to MongoDB | true |
| MONGO_HOST | server to connect to | store | 
| MONGO_PORT | port to connect to | 27017 | 
| MONGO_DB | database name | connpass-db |
| MONGO_USER | username | connpass-user |
| MONGO_PASS | password | 1234 | 
| MONGO_COLLECTION | collection name | events | 
 
