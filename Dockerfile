FROM gliderlabs/alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

ENV ELASTICSEARCH_HOME=/opt/elasticsearch \
    ELASTICSEARCH_NODENAME=node1 \
    ELASTICSEARCH_VERSION=1.7.0 \
    PATH=/opt/elasticsearch/bin/:$PATH \
    TIMEZONE=Europe/Warsaw


RUN apk --update add openjdk7-jre-base openssl tzdata\
    && mkdir -p ${ELASTICSEARCH_HOME} \
    && wget -O /tmp/elasticsearch.tar.gz https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz \
    && tar -C /tmp -xvzf /tmp/elasticsearch.tar.gz \
    && mv /tmp/elasticsearch-${ELASTICSEARCH_VERSION}/* /opt/elasticsearch \
    && rm -rf /tmp/elasticsearch.tar.gz /tmp/elasticsearch-${ELASTICSEARCH_VERSION} /var/cache/apk/* \
    && cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo "$TIMEZONE" >  /etc/timezone

EXPOSE 9200 9300

VOLUME ["/opt/elasticsearch/config", "/opt/elasticsearch/logs"]

CMD ["/opt/elasticsearch/bin/elasticsearch"]