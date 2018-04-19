#!/bin/sh

# lets copy over our compose incase of any changes
scp -o "StrictHostKeyChecking no" docker-compose.yml $DEPLOY_USER@$DEPLOY_SERVER:/spender_staging
ssh -o "StrictHostKeyChecking no" $DEPLOY_USER@$DEPLOY_SERVER "docker-compose -f docker-compose.staging.yml up -d --build ."
