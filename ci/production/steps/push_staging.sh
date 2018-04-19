#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS
docker tag superbikezacc/spender:latest superbikezacc/spender:$SEMVERSION
docker push superbikezacc/spender:production
docker push superbikezacc/spender:$SEMVERSION
