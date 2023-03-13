#!/bin/bash
result=0

CLONE_LINK="https://github.com/$GITHUB_REPOSITORY.git"

# Check if input pr is empty
if [[ -n $INPUT_FORK_REPO_NAME ]]; then
  # Replace CLONE_LINK
  CLONE_LINK="https://github.com/$INPUT_FORK_REPO_NAME.git"
fi

# Clone repo
echo "Cloning $CLONE_LINK"
echo ""
git clone --quiet $CLONE_LINK repo

# Checkout the current branch
CURR_BRANCH=${GITHUB_HEAD_REF}
echo "Current branch: $CURR_BRANCH"

BASE_BRANCH=${GITHUB_BASE_REF}
echo "Comparing to:   $BASE_BRANCH"
echo ""

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

# Print any unchanged tracked files
echo "Checking for changes in..."
echo "${tracked_files[@]}"
echo ""

for (( curr_file in ${tracked_files[@]} )); do
  if (( ! grep -Fxq "$curr_file" changed.txt )); then
    echo "$curr_file has not been updated"
    echo ""
    result=1
  fi
done

# Collect tracked fields
IFS="," read -a tracked_fields <<< $INPUT_TRACKED_FIELDS

# Print version number findings
if (( ${#tracked_fields[@]} % 2 == 0 )); then
  # Define arrays
  files=()
  fields=()
  matches=()

  # Allows us to treat matches like a set
  function add_unique_value() {
    local value=$1

    if [[  ! "${my_array[@]}" =~ "${value}" ]]; then
      matches+=("$value")
    fi
  }

  # Split the pairs
  for (( i=0; i<${#tracked_fields[@]}; i+=2 )); do
    files+=(${tracked_fields[$i]})
    fields+=(${tracked_fields[$i+1]})
  done

  # Run the searches
  for (( i=0; i<${#files[@]}; i+=1 )); do
    match=$(grep -oE "${fields[$i]}" "${files[$i]}" | head -n1)
    echo "${files[$i]} returned $match"
    echo ""
    add_unique_value "$match"
  done

  if [ "${#matches[@]}" -ne 1 ]; then
    echo "Multiple (or no) version numbers found"
    echo "Found: ${matches[@]}"
    echo ""
    result=1
  fi

else
  echo "ERROR in tracked_fields: array of odd length found. Please provide a list of pairs."
  echo ""
  result=1
fi

exit $result