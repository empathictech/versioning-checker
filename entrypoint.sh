#!/bin/bash
result=0

CLONE_LINK="https://github.com/$GITHUB_REPOSITORY.git"

# Replace CLONE_LINK if the user provided a fork name
if [[ -n $INPUT_FORK_REPO_NAME ]]; then
  CLONE_LINK="https://github.com/$INPUT_FORK_REPO_NAME.git"
fi

# Clone repo
echo "Cloning $CLONE_LINK"; echo ""
git clone --quiet $CLONE_LINK repo

# Checkout the current branch
CURR_BRANCH=${GITHUB_HEAD_REF}
echo "Current branch: $CURR_BRANCH"

BASE_BRANCH=${GITHUB_BASE_REF}
echo "Comparing to:   $BASE_BRANCH"; echo ""

cd repo
git checkout --quiet $CURR_BRANCH

# Collect changed files
if [[ -n $INPUT_FORK_REPO_NAME ]]; then
  git remote add $GITHUB_REPOSITORY "https://github.com/$GITHUB_REPOSITORY.git"
  git fetch $GITHUB_REPOSITORY
  git diff --name-only $CURR_BRANCH $GITHUB_REPOSITORY/$BASE_BRANCH >> changed.txt
else
  git diff --name-only $CURR_BRANCH $BASE_BRANCH >> changed.txt
fi

# Collect tracked files
IFS="," read -a tracked_files <<< $INPUT_TRACKED_FILES

echo "Validating: ${tracked_files[@]}"
echo ""

# Prep for version number matching
matches=()

# Function that allows us to treat matches like a set
function add_unique_value() {
  local value=$1

  if [[ ! "${matches[@]}" =~ "${value}" ]]; then
    matches+=("$value")
  fi
}

# Loop through the tracked files...
for (( curr_file in ${tracked_files[@]} )); do
  # ...check if they've been updated
  if (( ! grep -Fxq "$curr_file" changed.txt )); then
    echo "$curr_file has not been updated"; echo ""
    result=1
  fi

  # ...and get their version match
  match=$(grep -oE "$INPUT_VERSION_REGEX" "$curr_file" | head -n1)
  echo "$curr_file returned $match"; echo ""
  add_unique_value "$match"
done

if [ "${#matches[@]}" -ne 1 ]; then
  echo "Multiple (or no) version numbers found"
  echo "Found: ${matches[@]}"; echo ""
  result=1
fi

exit $result