# Versioning Checker

Simple Docker based GitHub Action that allows users to check if certain files have been changed on PRs. Default behavior is for the action to check for changes in `APP_VERSION` and `CHANGELOG.md` files, but the user can provide a comma seperated list (via String) of file names for the action to check for. The action uses a basic regex match so full paths do not need to be provided, only the file name (or portion of a file name for that matter).

# Inputs

## tracked_files

**Required** Comma separated String list of file names that need to be checked for updates.
Default `APP_VERSION,CHANGELOG.md`.

# Outputs

Will fail if any of the provided file names are not found in a git diff between the head and base branches of the PR. Each unchanged file will be echo'd to stdout in the Action Console.

# Example usage

[main.yml](.github/workflows/main.yml)

# Contributing

This is a made for one, shared to all style project. So, if you're a consumer and notice a bug please do leave an issue/comment. If it's extra features you desire, I recommend making your own fork. Thanks for stopping by!

This is released under the [MIT License](LICENSE)
