#!/bin/sh
docker login -u ${1} -p ${2}
docker tag spender:staging superbikezacc/spender:staging
docker push superbikezacc/spender:staging
