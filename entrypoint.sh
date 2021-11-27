#!/bin/bash
result=0

# Collect git information
CURR_BRANCH=${GITHUB_HEAD_REF}
echo "Current branch: $CURR_BRANCH"

BASE_BRANCH=${GITHUB_BASE_REF}
echo "Comparing to: $BASE_BRANCH"

# Clone repo
echo "Cloning $GITHUB_REPOSITORY"
REPO_LINK="https://github.com/$GITHUB_REPOSITORY.git"

git clone $REPO_LINK repo

# Checkout the current branch
cd repo
git checkout $CURR_BRANCH

# Collect changed files
git diff --name-only $CURR_BRANCH $BASE_BRANCH >> changed.txt

# Collect tracked files
IFS="," read -a tracked_files <<< $INPUT_TRACKED_FILES

# Print any unchanged tracked files
echo ""; echo "Checking for changes in ${tracked_files[@]}..."; echo ""
for f in ${tracked_files[@]}; do
  if ! grep -Fxq "$f" changed.txt
  then
    echo "$f has not been updated"
    result=1
  fi
done

exit $result
