# Create GitHub Issue

This skill creates a new GitHub issue using the GitHub API.

## Usage

Invoke this skill when the user wants to create a new GitHub issue. Gather the following information from the user:

- **Repository**: The repository in `owner/repo` format (required)
- **Title**: The issue title (required)
- **Body**: The issue description (optional)
- **Labels**: Comma-separated list of labels (optional)
- **Assignees**: Comma-separated list of GitHub usernames to assign (optional)

## Instructions

1. Ask the user for the required information (repository and title) if not provided
2. Run the `create-issue.sh` script with the appropriate arguments
3. Report the result to the user, including the issue URL if successful

## Script Usage

```bash
./skills/create-github-issue/create-issue.sh \
  --repo "owner/repo" \
  --title "Issue title" \
  [--body "Issue description"] \
  [--labels "bug,enhancement"] \
  [--assignees "user1,user2"]
```

## Environment Requirements

- `GITHUB_PAT`: A GitHub Personal Access Token with `repo` scope must be set in the environment

## Example

User: "Create an issue in myorg/myrepo titled 'Fix login bug' with label 'bug'"

```bash
./skills/create-github-issue/create-issue.sh \
  --repo "myorg/myrepo" \
  --title "Fix login bug" \
  --labels "bug"
```
