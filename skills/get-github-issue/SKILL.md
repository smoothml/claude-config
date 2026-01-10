---
name: get-github-issue
description: Get a GitHub issue from the current repository by issue number
---

# Get GitHub Issue

This skill retrieves a GitHub issue from the current repository using the GitHub API and returns its title and content as a single string.

## Usage

Invoke this skill when the user wants to fetch or view an existing GitHub issue. The issue number is required.

- **Issue Number**: The number of the issue to retrieve (required)

## Instructions

1. Ensure the user provides the issue number
2. Run the `get-issue` command with the issue number as an argument
3. Report the result to the user, displaying the issue title and content

## Script Usage

```bash
get-issue <issue-number>
```

### Examples

Get issue #42:
```bash
get-issue 42
```

Get issue #123:
```bash
get-issue 123
```

## Environment Requirements

- `GITHUB_PAT`: A GitHub Personal Access Token with `repo` scope must be set in the environment
- Must be run from within a git repository with a GitHub remote

## Example

User: "Get issue #15"

```bash
get-issue 15
```

Output:
```
Fix login button not responding

The login button on the main page does not respond when clicked.

## Steps to reproduce
1. Go to the login page
2. Enter credentials
3. Click the login button

Nothing happens when the button is clicked.
```
