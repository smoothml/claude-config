#!/bin/bash
#
# Create a GitHub issue using the GitHub API
#
# Requirements:
#   - GITHUB_PAT environment variable must be set with a valid GitHub Personal Access Token
#   - curl must be installed
#
# Usage:
#   ./create-issue.sh --repo "owner/repo" --title "Issue title" [--body "description"] [--labels "label1,label2"] [--assignees "user1,user2"]
#

set -e

# Default values
REPO=""
TITLE=""
BODY=""
LABELS=""
ASSIGNEES=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --repo)
            REPO="$2"
            shift 2
            ;;
        --title)
            TITLE="$2"
            shift 2
            ;;
        --body)
            BODY="$2"
            shift 2
            ;;
        --labels)
            LABELS="$2"
            shift 2
            ;;
        --assignees)
            ASSIGNEES="$2"
            shift 2
            ;;
        *)
            echo "Error: Unknown option $1" >&2
            echo "Usage: $0 --repo 'owner/repo' --title 'Issue title' [--body 'description'] [--labels 'label1,label2'] [--assignees 'user1,user2']" >&2
            exit 1
            ;;
    esac
done

# Validate required arguments
if [[ -z "$REPO" ]]; then
    echo "Error: --repo is required" >&2
    exit 1
fi

if [[ -z "$TITLE" ]]; then
    echo "Error: --title is required" >&2
    exit 1
fi

# Validate GITHUB_PAT
if [[ -z "$GITHUB_PAT" ]]; then
    echo "Error: GITHUB_PAT environment variable is not set" >&2
    echo "Please set GITHUB_PAT with a valid GitHub Personal Access Token" >&2
    exit 1
fi

# Build the JSON payload
JSON_PAYLOAD=$(jq -n \
    --arg title "$TITLE" \
    --arg body "$BODY" \
    '{title: $title, body: $body}')

# Add labels if provided
if [[ -n "$LABELS" ]]; then
    # Convert comma-separated labels to JSON array
    LABELS_JSON=$(echo "$LABELS" | jq -R 'split(",")')
    JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --argjson labels "$LABELS_JSON" '. + {labels: $labels}')
fi

# Add assignees if provided
if [[ -n "$ASSIGNEES" ]]; then
    # Convert comma-separated assignees to JSON array
    ASSIGNEES_JSON=$(echo "$ASSIGNEES" | jq -R 'split(",")')
    JSON_PAYLOAD=$(echo "$JSON_PAYLOAD" | jq --argjson assignees "$ASSIGNEES_JSON" '. + {assignees: $assignees}')
fi

# Make the API request
API_URL="https://api.github.com/repos/${REPO}/issues"

RESPONSE=$(curl -s -w "\n%{http_code}" \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${GITHUB_PAT}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -d "$JSON_PAYLOAD" \
    "$API_URL")

# Extract HTTP status code and response body
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
RESPONSE_BODY=$(echo "$RESPONSE" | sed '$d')

# Check for success
if [[ "$HTTP_CODE" -eq 201 ]]; then
    ISSUE_URL=$(echo "$RESPONSE_BODY" | jq -r '.html_url')
    ISSUE_NUMBER=$(echo "$RESPONSE_BODY" | jq -r '.number')
    echo "Successfully created issue #${ISSUE_NUMBER}"
    echo "URL: ${ISSUE_URL}"
else
    echo "Error: Failed to create issue (HTTP ${HTTP_CODE})" >&2
    echo "$RESPONSE_BODY" | jq -r '.message // .' >&2
    exit 1
fi
