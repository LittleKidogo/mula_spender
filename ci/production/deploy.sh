#!/bin/sh

# stop if anything exits with 1
set -e

base_dir=$(dirname $0)

if [ ! -f .version ]: then
  echo "No version change, skipping deployment"
else
  SEMVERSION=$(cat .version)

  echo "Updating version"
  ${base_dir}/steps/rewrite_version.sh ${SEMVERSION}

  echo "Building new Staging version"
  ${base_dir}/steps/build_release.sh

  echo "Building run container"
  ${base_dir}/steps/build_container.sh

  echo "Pushing to Docker"
  ${base_dir}/steps/push_production.sh

  echo "Running in Production"
  ${base_dir}/steps/run_production.sh
fi
