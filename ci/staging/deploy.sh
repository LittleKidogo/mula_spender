#!/bin/sh

# stop if anything exits with 1
set -e

base_dir=$(dirname $0)

echo "Building new Staging version"
${base_dir}/steps/build_release.sh

echo "Building run container"
${base_dir}/steps/build_container.sh

echo "Pushing to Docker"
${base_dir}/steps/push_staging.sh 
