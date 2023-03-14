#!/bin/bash
result=0

CLONE_LINK="https://github.com/$GITHUB_REPOSITORY.git"

# Replace CLONE_LINK if the user provided a fork name
if [[ -n $INPUT_FORK_REPO_NAME ]]; then
  CLONE_LINK="https://github.com/$INPUT_FORK_REPO_NAME.git"
fi

# Clone repo
printf "Cloning:\n\t$GITHUB_REPOSITORY\n\n"
git clone --quiet $CLONE_LINK repo

# Checkout the current branch
CURR_BRANCH=${GITHUB_HEAD_REF}
BASE_BRANCH=${GITHUB_BASE_REF}
printf "Comparing branch $CURR_BRANCH to $BASE_BRANCH\n\n"

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

printf "Validating:\n\t"
echo "${tracked_files[@]}"; echo ""

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
for curr_file in ${tracked_files[@]} ; do
  # ...check if they've been updated
  if ! grep -Fxq "$curr_file" changed.txt ; then
    printf "$curr_file has NOT been updated "
    result=1
  else 
    printf "$curr_file has been updated "
  fi

  # ...and get their version match
  match=$(grep -oE "$INPUT_VERSION_REGEX" "$curr_file" | head -n1)
  printf "and returned $match\n"
  add_unique_value "$match"
done

echo ""
printf "${#matches[@]}"
printf " version(s) found:\n\t"
printf "${matches[@]}"
echo ""

if [ "${#matches[@]}" -ne 1 ]; then
  result=1
fi

if [ $result -ne 0 ]; then
  printf "\nErrors found\n"
  exit $result
else 
  printf "\nPassed!\n"
  exit $result
fi