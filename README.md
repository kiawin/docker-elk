# Docker for ELK. Elasticsearch. Logstash. Kibana

## Setup

### Via Docker Hub

Coming soon

### Manual
Build the docker image

```
docker-compose build
```

Start the docker container

```
docker-compose up -d
```

View the logs

```
docker-compose logs
```

## Customization

### docker-compose.yml
* data volume path (currently defaulted to /data/elk)

```
elk:
    volumes:
        - [/path/to/your/host/data/folder]/log/logstash:/var/log/logstash
        - [/path/to/your/host/data/folder]/log/elasticsearch:/var/log/elasticsearch

dataelk:
    volumes:
        - [/path/to/your/host/data/folder]
```

# Copyright
Based on willdurand/elk

* Docker Hub [https://registry.hub.docker.com/u/willdurand/elk/]
* GitHub [https://github.com/willdurand/docker-elk]
