#!/bin/bash

set -ex

if [[ $(git diff ".api-version") != "" ]]; then
  UPDATED_VERSION=$(cat ".api-version")
  BRANCH_NAME="version-up-to-$UPDATED_VERSION-$(date +%s)"
  git switch -c "$BRANCH_NAME"
  git add ".api-version"
  COMMIT_MESSAGE="Bump up version to $UPDATED_VERSION"
  git commit -m "$COMMIT_MESSAGE"
  git push origin "$BRANCH_NAME"
  URL="https://api.github.com/repos/$OWNER/$REPO/pulls"
  LOGS=$(./scripts/last_commit.sh | tr "\n" "\\n")
  DATA="{\"title\": \"$COMMIT_MESSAGE\", \"body\": \"${LOGS//$'\n'/\\n}\", \"head\": \"$BRANCH_NAME\", \"draft\": false, \"base\": \"$BASE_BRANCH\"}"
  curl -d "$DATA" -X POST -s -H "Authorization: token $GITHUB_TOKEN" "$URL"
fi