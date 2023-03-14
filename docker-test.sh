#!/bin/bash

IMAGE_NAME="versioning-checker-test"
CURR_BRANCH=$(git rev-parse --abbrev-ref HEAD)

docker build -t $IMAGE_NAME .

docker run \
  -e GITHUB_REPOSITORY='empathictech/versioning-checker' -e GITHUB_HEAD_REF=$(CURR_BRANCH) -e GITHUB_BASE_REF='main' \
  -e INPUT_TRACKED_FILES='APP_VERSION,CHANGELOG.md' -e INPUT_VERSION_REGEX='^[0-9]+\.[0-9]+\.[0-9]+$' \
  -e INPUT_FORK_REPO_NAME='' \
  -it $(IMAGE_NAME):$(APP_VERSION) 