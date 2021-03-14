#!/bin/bash

result=0

# Collect git information
branch=${GITHUB_HEAD_REF}
base=${GITHUB_BASE_REF}
clone_link="https://github.com/$GITHUB_REPOSITORY.git"

# Clone repo
git clone $clone_link repo
cd repo
git checkout $branch

# Collect changed files
git diff --name-only $branch $base >> changed.txt

# Collect tracked files
IFS="," read -a tracked_files <<< $1

# Print any unchanged tracked files
for f in ${tracked_files[@]}; do
  if ! grep -Fxq "$f" changed.txt
  then
    echo "$f has not been updated"
    result=1
  fi
done

exit $result
