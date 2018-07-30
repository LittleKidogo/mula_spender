FROM littlekidogo/alpine-elixir-phoenix

MAINTAINER Little Kidogo <greetings@littlekidogo.co.za>

RUN apk add --no-cache openssh


# Install dockerize

RUN wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-alpine-linux-amd64-v0.6.1.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-v0.6.1.tar.gz \
    && rm dockerize-alpine-linux-amd64-v0.6.1.tar.gz


# Add docker

RUN apk add docker

# Install Semantic Release

ENV SEMANTIC_RELEASE_VERSION=1.9.1

ADD https://github.com/go-semantic-release/semantic-release/releases/download/v${SEMANTIC_RELEASE_VERSION}/semantic-release_v${SEMANTIC_RELEASE_VERSION}_linux_amd64 /usr/local/bin/semantic-release
RUN chmod a+x /usr/local/bin/semantic-release
