---
name: create-github-pr
description: Create a new GitHub pull request in the current repository
---

# Create GitHub Pull Request

This skill creates a new GitHub pull request in the current repository using the GitHub API. Use this skill to submit work developed in the current coding session for review.

## Usage

Invoke this skill when the user wants to create a new GitHub pull request. Gather the following information:

- **Title**: The PR title (required)
- **Head**: The source branch containing the changes (required, defaults to current branch)
- **Base**: The target branch to merge into (optional, defaults to repository's default branch)
- **Body**: The PR description (optional)
- **Draft**: Whether to create as a draft PR (optional, defaults to false)

## Instructions

1. Determine the source branch (head) - use the current branch if not specified
2. Determine the target branch (base) - use the repository's default branch if not specified
3. Ask the user for the PR title if not provided
4. Summarize the changes for the PR body based on the work done in the session
5. Run the `create-pr` command with the appropriate arguments
6. Report the result to the user, including the PR URL if successful

## Script Usage

```bash
create-pr \
  --title "PR title" \
  --head "feature-branch" \
  [--base "main"] \
  [--body "PR description"] \
  [--draft]
```

### Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `--title` | Yes | The title of the pull request |
| `--head` | Yes | The name of the branch containing your changes |
| `--base` | No | The name of the branch you want to merge into (defaults to repo's default branch) |
| `--body` | No | The description of the pull request |
| `--draft` | No | Flag to create the PR as a draft (no value needed) |

## Formatting the Body

The `--body` argument supports escape sequences for markdown formatting:

- Use `\n` for newlines
- Use `\t` for tabs
- Escape quotes inside the body with a backslash: `\"` or use single quotes around the argument

### Examples

Basic PR creation:
```bash
create-pr \
  --title "Add user authentication" \
  --head "feature/auth" \
  --base "main"
```

PR with description:
```bash
create-pr \
  --title "Fix login bug" \
  --head "fix/login-issue" \
  --body "## Summary\n\nFixes the login button not responding on mobile devices.\n\n## Changes\n\n- Updated click handler\n- Added touch event support"
```

Draft PR:
```bash
create-pr \
  --title "WIP: New dashboard" \
  --head "feature/dashboard" \
  --draft
```

PR with body containing quotes:
```bash
create-pr \
  --title "Update error messages" \
  --head "fix/errors" \
  --body 'Changed error from "Unknown error" to a more descriptive message.'
```

## Environment Requirements

- `GITHUB_PAT`: A GitHub Personal Access Token with `repo` scope must be set in the environment
- Must be run from within a git repository with a GitHub remote
- The head branch must be pushed to the remote before creating a PR

## Workflow Example

User: "Create a PR for the changes I just made"

1. Check the current branch name
2. Ensure changes are committed and pushed
3. Summarize the work done in the session for the PR body
4. Run the command:

```bash
create-pr \
  --title "Add new feature X" \
  --head "feature/x" \
  --base "main" \
  --body "## Summary\n\nAdded feature X as requested.\n\n## Changes\n\n- Implemented X component\n- Added tests for X"
```
