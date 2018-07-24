#!/bin/sh


# lets copy over our compose incase of any changes
scp -i /home/lk_admin/.ssh/id_rsa -o "StrictHostKeyChecking no" docker-compose.staging.yml ${1}@${2}:/home/${1}/spender_staging
ssh -i /home/lk_admin/.ssh/id_rsa -o "StrictHostKeyChecking no" ${1}@${2} "cd spender_staging; docker-compose -f docker-compose.staging.yml pull; docker-compose -f docker-compose.staging.yml up -d --build web"
