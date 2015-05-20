FROM java:openjdk-8-jre
MAINTAINER Sian Lerk Lau <kiawin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# General
RUN apt-get update
RUN apt-get install -y supervisor curl

# Elasticsearch
RUN \
    apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4 && \
    if ! grep "elasticsearch" /etc/apt/sources.list; then echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list;fi && \
    if ! grep "logstash" /etc/apt/sources.list; then echo "deb http://packages.elasticsearch.org/logstash/1.4/debian stable main" >> /etc/apt/sources.list;fi && \
    apt-get update

RUN \
    apt-get install -y elasticsearch && \
    apt-get clean

## For distribution
#ADD etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
#ADD etc/supervisor/conf.d/elasticsearch.conf /etc/supervisor/conf.d/elasticsearch.conf

## For development
RUN ln -fs /data/etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
RUN ln -fs /data/etc/supervisor/conf.d/elasticsearch.conf /etc/supervisor/conf.d/elasticsearch.conf

# Logstash
RUN apt-get install -y logstash logstash-contrib && \
    apt-get clean

## For distribution
#ADD etc/logstash/conf.d/logstash.conf /etc/logstash/conf.d/logstash.conf
#ADD etc/supervisor/conf.d/logstash.conf /etc/supervisor/conf.d/logstash.conf

## For development
RUN ln -fs /data/etc/logstash/conf.d/logstash.conf /etc/logstash/conf.d/logstash.conf
RUN ln -fs /data/etc/supervisor/conf.d/logstash.conf /etc/supervisor/conf.d/logstash.conf

# Kibana
RUN \
    curl -s https://download.elasticsearch.org/kibana/kibana/kibana-4.0.1-linux-x64.tar.gz | tar -C /opt -xz && \
    ln -s /opt/kibana-4.0.1-linux-x64 /opt/kibana

## For distribution
#ADD opt/kibana/config/kibana.yml /opt/kibana/config/kibana.yml
#ADD etc/supervisor/conf.d/kibana.conf /etc/supervisor/conf.d/kibana.conf

## For development
RUN ln -fs /data/opt/kibana/config/kibana.yml /opt/kibana/config/kibana.yml
RUN ln -fs /data/etc/supervisor/conf.d/kibana.conf /etc/supervisor/conf.d/kibana.conf

# Open port
EXPOSE 514
EXPOSE 9200
EXPOSE 5601

# Run supervisord
CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]

