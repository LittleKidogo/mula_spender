#!/bin/sh

# lets copy over our compose incase of any changes
scp -o "StrictHostKeyChecking no" docker-compose.yml ${1}@${2}:/${1}/spender_staging
scp -o "StrictHostKeyChecking no" docker-compose.staging.yml ${1}@${2}:/${1}/spender_staging
ssh -o "StrictHostKeyChecking no" ${1}@${2} "cd spender_staging; pwd; ls -l; docker-compose -f docker-compose.staging.yml up -d --build web"
