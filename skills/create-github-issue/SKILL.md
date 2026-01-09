---
name: create-github-issue
description: Create a new GitHub issue in the current repository
---

# Create GitHub Issue

This skill creates a new GitHub issue in the current repository using the GitHub API.

## Usage

Invoke this skill when the user wants to create a new GitHub issue. Gather the following information from the user:

- **Title**: The issue title (required)
- **Body**: The issue description (optional)
- **Labels**: Comma-separated list of labels (optional)

## Instructions

1. Ask the user for the required information (title) if not provided
2. Run the `create-issue` command with the appropriate arguments
3. Report the result to the user, including the issue URL if successful

## Script Usage

```bash
create-issue \
  --title "Issue title" \
  [--body "Issue description"] \
  [--labels "bug,enhancement"]
```

## Formatting the Body

The `--body` argument supports escape sequences for markdown formatting:

- Use `\n` for newlines
- Use `\t` for tabs
- Escape quotes inside the body with a backslash: `\"` or use single quotes around the argument

### Examples

Multi-line body with markdown:
```bash
create-issue \
  --title "Bug report" \
  --body "## Description\n\nThe login button is broken.\n\n## Steps to reproduce\n\n1. Go to login page\n2. Click submit"
```

Body containing quotes (escape inner quotes):
```bash
create-issue \
  --title "Error message unclear" \
  --body "The error says \"invalid input\" but doesn't explain why."
```

Body containing quotes (use single quotes):
```bash
create-issue \
  --title "Error message unclear" \
  --body 'The error says "invalid input" but does not explain why.'
```

## Environment Requirements

- `GITHUB_PAT`: A GitHub Personal Access Token with `repo` scope must be set in the environment
- Must be run from within a git repository with a GitHub remote

## Example

User: "Create an issue titled 'Fix login bug' with label 'bug'"

```bash
create-issue \
  --title "Fix login bug" \
  --labels "bug"
```
