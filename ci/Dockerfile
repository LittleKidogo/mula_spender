FROM bitwalker/alpine-elixir-phoenix

LABEL maintainer="Zacck Osiemo"

RUN apk add --no-cache openssh


# Install dockerize

RUN wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-alpine-linux-amd64-v0.6.1.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-v0.6.1.tar.gz \
    && rm dockerize-alpine-linux-amd64-v0.6.1.tar.gz

# Install Docker in Docker

ENV DOCKER_VERSION="17.05.0-ce"

RUN wget https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz \
    && tar -C /usr/local/bin -xzvf docker-$DOCKER_VERSION.tgz \
    && rm docker-$DOCKER_VERSION.tgz

# Docker Cloud

RUN apk -Uuv --no-cache add python py-pip

ENV DOCKER_CLOUD_VERSION="1.0.9"
RUN pip install docker-cloud==${DOCKER_CLOUD_VERSION}

# Install Semantic Release

ENV SEMANTIC_RELEASE_VERSION=1.9.1

ADD https://github.com/go-semantic-release/semantic-release/releases/download/v${SEMANTIC_RELEASE_VERSION}/semantic-release_v${SEMANTIC_RELEASE_VERSION}_linux_amd64 /usr/local/bin/semantic-release
RUN chmod a+x /usr/local/bin/semantic-release
