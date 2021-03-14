#!/bin/bash
result=0

# Collect git information
branch=${GITHUB_HEAD_REF}
base=${GITHUB_BASE_REF}
clone_link="https://github.com/$GITHUB_REPOSITORY.git"

# Clone repo
echo "Cloning $GITHUB_REPOSITORY"
git clone $clone_link repo
cd repo
git checkout $branch

# Collect changed files
git diff --name-only $branch $base >> changed.txt

# Collect tracked files
IFS="," read -a to_track <<< $tracked_files

# Print any unchanged tracked files
echo ""; echo "Checking for changes in ${to_track[@]}..."; echo ""
for f in ${to_track[@]}; do
  if ! grep -Fxq "$f" changed.txt
  then
    echo "$f has not been updated"
    result=1
  fi
done

exit $result
