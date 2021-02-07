#!/bin/bash

set -ex

LATEST_COMMIT=$(git log --pretty=format:"%s" --no-merges -1)
if [[ "$LATEST_COMMIT" =~ ^"Bump" ]]; then
  VERSION=$(cat ".api-version")
  LOGS=$(./scripts/last_commit.sh)
  URL="https://api.github.com/repos/$OWNER/$REPO/releases"
  DATA="{\"tag_name\": \"v$VERSION\", \"target_commitish\": \"master\", \"name\": \"v$VERSION\", \"body\": \"${LOGS//$'\n'/\\n}\", \"draft\": false, \"prerelease\": false}"
  curl -d "$DATA" -X POST -s -H "Authorization: token $GITHUB_TOKEN" "$URL"
else
  echo "Not Updated"
fi