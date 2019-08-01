FROM ubuntu:18.04
MAINTAINER loftkun https://twitter.com/loftkun

RUN apt-get update
RUN apt-get install -y git curl jq

# DB
# redis
#RUN apt-get install -y redis-tools

# mongo-org-shell
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-get install -y gnupg
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN apt-get update
RUN apt-get install -y mongodb-org-shell

ENV APP=connpass-cron-search
COPY ./src /${APP}

WORKDIR /${APP}
RUN git clone https://github.com/loftkun/connpass-api-shell-scripts.git api-shell-scripts
CMD ["/bin/bash", "-c", "/${APP}/main.sh"]
