# Changelog

All notable changes to this project will be documented in this file.

## v3.0: 2021-11-22
### Updates/Fixes
 - Adding support for PRs from forks
  - https://github.com/mwcodebase/versioning-checker/issues/6
  - requires major version update as the steps to run the action have changed

## v2.2: 2021-03-14
### Updates/Fixes
 - Fixed typos in README.md, no code/functionality changes

## v2.1: 2021-03-14
### Updates/Fixes
 - Added more verbose logging
 - Fixed bug in 2.0 where default input was not being accessed properly

## v2.0: 2021-03-14
### Updates
 - Updated the action to allow users to provide a comma seperated list (via String) of all file names that should be tracked. Defaults to APP_VERSION and CHANGELOG.md, so default behavior is (mostly, see below) unchanged.
 - Updated action to use base repo field of from pull request data. This way, the action works on any branch PR not just PRs to the master branch.
 - Updated action to no longer search for complete line matches. This way file names can be provided without the full path. For example, if a user wanted to store the APP_VERSION and CHANGELOG.md files in a `/docs` directory.
  - *RELEASE DELETED*

## v1.0: 2021-03-14
### Updates
 - Fixed bash script error from previous release
 - Fully functional action that checks for updated versioning files

## v0.3-testing: 2021-03-13
### Updates
 - Switched to Docker based action
 - Updated action to (hopefully) fail on whether the APP_VERSION and CHANGELOG.md files have been updated
  - *RELEASE DELETED*

## v0.2-alpha: 2021-02-28
### Updates
 - Completed alpha version of the action; a functioning "Hello World" javascript action
  - *RELEASE DELETED*

##  v0.1: 2021-02-27
### Initialized
 - Initial commit of repo
  - *RELEASE DELETED*