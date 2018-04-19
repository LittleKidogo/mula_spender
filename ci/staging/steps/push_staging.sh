#!/bin/sh
docker login -u $DOCKER_USER -p $DOCKER_PASS
docker tag superbikezacc/spender:staging
docker push superbikezacc/spender:staging
