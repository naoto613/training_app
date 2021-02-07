#!/bin/bash

set -ex

if [[ $(git diff origin/$DEPLOY_BRANCH origin/$BASE_BRANCH ".api-version") != "" ]]; then
  UPDATED_VERSION=$(cat ".api-version")
  BRANCH_NAME="$DEPLOY_BRANCH-v$UPDATED_VERSION"
  git switch -c "$BRANCH_NAME" "$BASE_BRANCH"
  git push -u origin "$BRANCH_NAME"
  COMMIT_MESSAGE="patch-chore: Bump up version to $DEPLOY_BRANCH v$UPDATED_VERSION"
  URL="https://api.github.com/repos/$OWNER/$REPO/pulls"
  DATA="{\"title\": \"$COMMIT_MESSAGE\", \"head\": \"$BRANCH_NAME\", \"draft\": false, \"base\": \"$DEPLOY_BRANCH\"}"
  curl -d "$DATA" -X POST -s -H "Authorization: token $GITHUB_TOKEN" "$URL"
fi