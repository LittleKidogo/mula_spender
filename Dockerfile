FROM alpine:3.6

# we need bash and openssl for Phoenix
RUN apk upgrade --no-cache && \
    apk add --no-cache bash openssl

# set and expose port
EXPOSE 5002

ENV PORT=5002 \
    REPLACE_OS_VARS=true \
    SHELL=/bin/bash

ARG VERSION

ARG SEMVERSION=0.0.3-rcwishlist


WORKDIR /app

ADD Dockerfile /app
#copy release artefact from last stage
ADD _build/prod/rel/spender/releases/${SEMVERSION}/vm.args /app
ADD _build/prod/rel/spender/releases/${SEMVERSION}/spender.tar.gz /app

RUN chown -R root ./releases

USER root

CMD ["/app/bin/spender", "foreground"]
