FROM alpine:3.6

# we need bash and openssl for Phoenix
RUN apk upgrade --no-cache && \
    apk add --no-cache bash openssl

# set and expose port
EXPOSE 5002

ENV PORT=5002 \
    MIX_ENV=prod \
    REPLACE_OS_VARS=true \
    SHELL=/bin/bash

ARG VERSION

WORKDIR /app

#copy release artefact from last stage
COPY --from=builder /app/_build/prod/rel/spender/releases/${VERSION}/spender.tar.gz .

RUN tar zxf spender.tar.gz && rm spender.tar.gz

RUN chown -R root ./releases

USER root

CMD ["/app/bin/spender", "foreground"]
