#!/bin/sh -l

token=$1
branch=${GITHUB_REF##*/}
clone_link="https://github.com/$GITHUB_REPOSITORY.git"

git clone $clone_link repo
cd repo
git checkout $branch

git diff --name-only $branch master >> changed.txt

if ! grep -Fxq "APP_VERSION" changed.txt
then
  echo "APP_VERSION file not updated."
  exit 1
fi

if ! grep -Fxq "CHANGELOG.md" changed.txt
then
  echo "CHANGELOG.md file not updated."
  exit 1
fi
