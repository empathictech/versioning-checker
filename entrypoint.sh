#!/bin/sh

token=$1
branch=${GITHUB_REF}

echo $branch

clone_link="https://github.com/$GITHUB_REPOSITORY.git"

echo $clone_link

pwd
ls

git clone $clone_link repo

ls

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
