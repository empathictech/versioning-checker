#!/bin/bash
result=0

CURR_BRANCH=${GITHUB_HEAD_REF}
echo "Current branch: $CURR_BRANCH"

BASE_BRANCH=${GITHUB_BASE_REF}
echo "Comparing to: $BASE_BRANCH"

CLONE_LINK="https://github.com/$GITHUB_REPOSITORY.git"

# Check if input pr is empty
if [[ -n $INPUT_PR_SOURCE_REPO ]]; then
  # Replace CLONE_LINK
  CLONE_LINK="https://github.com/$INPUT_PR_SOURCE_REPO.git"
fi

# Clone repo
echo "Cloning $CLONE_LINK"
git clone $CLONE_LINK repo

# Checkout the current branch
cd repo
git checkout $CURR_BRANCH

# Collect changed files
if [[ -n $INPUT_PR_SOURCE_REPO ]]; then
  git diff --name-only $INPUT_PR_SOURCE_REPO/$CURR_BRANCH $GITHUB_REPOSITORY/$BASE_BRANCH >> changed.txt
else
  git diff --name-only $CURR_BRANCH $BASE_BRANCH >> changed.txt
fi

# Collect tracked files
IFS="," read -a tracked_files <<< $INPUT_TRACKED_FILES

# Print any unchanged tracked files
echo ""; echo "Checking for changes in ${tracked_files[@]}..."; echo ""
for f in ${tracked_files[@]}; do
  if ! grep -Fxq "$f" changed.txt; then
    echo "$f has not been updated"
    result=1
  fi
done

exit $result