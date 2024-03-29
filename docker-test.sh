#!/bin/bash

set -e

# Define docker parameters

if [[ "$(uname -m)" == "arm"* ]]; then
  IMAGE_NAME="versioning-checker-arm-test"
  DOCKERFILE="-f ./arm-test/Dockerfile ."
else
  IMAGE_NAME="versioning-checker-test"
  DOCKERFILE="."
fi

GITHUB_REPOSITORY="empathictech/versioning-checker"
CURR_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GITHUB_BASE_REF="main"

INPUT_TRACKED_FILES="APP_VERSION,CHANGELOG.md"
INPUT_VERSION_REGEX="[0-9]+\.[0-9]+\.[0-9]+"
INPUT_FORK_REPO_NAME=""

# Run docker cmds

docker build -t $IMAGE_NAME $DOCKERFILE

docker run \
  -e GITHUB_REPOSITORY=$GITHUB_REPOSITORY -e GITHUB_HEAD_REF=$CURR_BRANCH -e GITHUB_BASE_REF=$GITHUB_BASE_REF \
  -e INPUT_TRACKED_FILES=$INPUT_TRACKED_FILES -e INPUT_VERSION_REGEX=$INPUT_VERSION_REGEX \
  -e INPUT_FORK_REPO_NAME=$INPUT_FORK_REPO_NAME \
  -it $IMAGE_NAME