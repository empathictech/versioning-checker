# Versioning Checker

Docker based GitHub Action for verifying version update propagation. Aka automated mistake prevention.

The action's default behavior is to do two things...
1. Verify that the `APP_VERSION` and `CHANGELOG.md` files have been updated (it assumes they're present)
2. Verify that the first version number found in those files are the same

The user can overwrite the list of files to check via a comma seperated string of file names.
The user can also overwrite the versioning regular expression.

The script will output any mistakes found and exit on pass/fail.

This GitHub Action does support forked repos, but fork users will need to provide their unqiue [repo info](#inputs)

# Inputs

## tracked_files

Comma separated list of all files that track the version.
- Default: `APP_VERSION,CHANGELOG.md`

## version_regex

Regular expression for the version pattern. The script will use the first match of this regex in each tracked file.
- Default: '^[0-9]+\.[0-9]+\.[0-9]+$'

## fork_repo_name

PRs from forked repos do not work by default. If this PR is from a forked repo, provide the new REPO_NAME (https://github.com/[REPO_NAME].git)

# Outputs

The script will fail if any of the provided file names are not found in a git diff between the head and base branches of the PR. Each unchanged file will be echo'd to stdout in the Action Console.

The script will also fail if multiple (or no) version numbers are found. Each version number will be echo'd to stdout in the Action Console.

# Example usage

[main.yml](.github/workflows/main.yml)

# Contributing

This is a made for one, shared to all style project. So, if you're a consumer and notice a bug please do leave an issue/comment. If it's extra features you desire, I recommend making your own fork. Thanks for stopping by!

This is released under the [MIT License](LICENSE)

## Testing

Run
```bash
./docker-test.sh
```