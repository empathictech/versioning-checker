#!/bin/bash
result=0

# Collect git information
CURR_BRANCH=${GITHUB_HEAD_REF}
echo "Current branch: $CURR_BRANCH"

BASE_BRANCH=${GITHUB_BASE_REF}
echo "Comparing to: $BASE_BRANCH"

# Clone repo (sent from action.yml)
echo "Cloning $1"
git clone https://github.com/$1.git repo

# Checkout the current branch
cd repo
git checkout $CURR_BRANCH

# Collect changed files
git diff --name-only $GITHUB_REPOSITORY/$BASE_BRANCH >> changed.txt

# Collect tracked files
IFS="," read -a tracked_files <<< $INPUT_TRACKED_FILES

# Print any unchanged tracked files
echo ""; echo "Checking for changes in ${tracked_files[@]}..."; echo ""
for f in ${tracked_files[@]}; do
  if ! grep -Fxq "$f" changed.txt then
    echo "$f has not been updated"
    result=1
  fi
done

exit $result