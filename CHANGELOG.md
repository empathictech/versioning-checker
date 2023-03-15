# Changelog

All notable changes to this project will be documented in this file.

## 2.1.5: 2023-03-15
### Added
- Bug fixes

### Changed
- Testing scripts; single script will now detect processor type

## 2.1.4: 2023-03-13
### Removed
- Funding.yml

### Changed
- .yml files to .yaml
- Versioning strategy

### Added
- Version field matching

## 2.3: 2022-12-20
### Fixed
- Adding support for PRs from forks with new input param
 - https://github.com/mwcodebase/versioning-checker/issues/6
- Updated documentation

## 2.2: 2021-03-14
### Fixed
- Fixed typos in README.md, no code/functionality changes

## 2.1: 2021-03-14
### Fixed
- Added more verbose logging
- Fixed bug in 2.0 where default input was not being accessed properly

## 2.0: 2021-03-14
### Changed
- Updated the action to allow users to provide a comma seperated list (via String) of all file names that should be tracked. Defaults to APP_VERSION and CHANGELOG.md, so default behavior is (mostly, see below) unchanged.
- Updated action to use base repo field of from pull request data. This way, the action works on any branch PR not just PRs to the master branch.
- Updated action to no longer search for complete line matches. This way file names can be provided without the full path. For example, if a user wanted to store the APP_VERSION and CHANGELOG.md files in a `/docs` directory.
 - *RELEASE DELETED*

## 1.0: 2021-03-14
### Fixed
- Fixed bash script error from previous release
- Fully functional action that checks for updated versioning files

## 0.3-testing: 2021-03-13
### Changed
- Switched to Docker based action
- Updated action to (hopefully) fail on whether the APP_VERSION and CHANGELOG.md files have been updated
 - *RELEASE DELETED*

## 0.2-alpha: 2021-02-28
### Changed
- Completed alpha version of the action; a functioning "Hello World" javascript action
 - *RELEASE DELETED*

## 0.1: 2021-02-27
### Added
- Initial commit of repo
 - *RELEASE DELETED*

# Template

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## [X.X.X] - YYYY-MM-DD
### Added 
- Things added

### Removed
- Things removed

### Changed
- Things changed

### Fixed
- Things fixed