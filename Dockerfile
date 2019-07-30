FROM ubuntu:19.10
MAINTAINER loftkun https://twitter.com/loftkun

RUN apt-get update
RUN apt-get install -y git curl jq redis-tools

ENV APP=connpass-cron-search
COPY ./src /${APP}

WORKDIR /${APP}
RUN git clone https://github.com/loftkun/connpass-api-shell-scripts.git api-shell-scripts
CMD ["/bin/bash", "-c", "/${APP}/main.sh"]
