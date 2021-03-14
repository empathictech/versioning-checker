#!/bin/sh -l

token=$1
echo $GITHUB_REPOSITORY
pwd
ls -lah

# branch=$(git branch --show-current)
# git diff --name-only $branch master >> changed.txt

# if ! grep -Fxq "APP_VERSION" changed.txt
# then
#   echo "APP_VERSION file not updated."
#   exit 1
# fi

# if ! grep -Fxq "CHANGELOG.md" changed.txt
# then
#   echo "CHANGELOG.md file not updated."
#   exit 1
# fi
