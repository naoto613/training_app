#!/bin/bash

set -ex
getopts "p" INCLUDE_PATCH || true

CURRENT=$(cat ".api-version")
COMMIT_LIST=$(git log --pretty=format:"%s" --no-merges "v$CURRENT..HEAD" | grep -o '\(^major\)\|\(^minor\)\|\(^patch\)' || echo "")

next_version() {
  if [[ $4 =~ (^|[[:space:]])"major"($|[[:space:]]) ]] ; then
    echo $(($1+1)).0.0
  elif [[ $4 =~ (^|[[:space:]])"minor"($|[[:space:]]) ]] ; then
    echo "$1.$(($2+1)).0"
  elif [[ $INCLUDE_PATCH == "p" ]] ; then
    echo "$1.$2.$(($3+1))"
  else
    echo "$1.$2.$3"
  fi
}

IFS='.' read -r -a SEMVER <<< "$CURRENT"
UPDATED_VERSION=$(next_version "${SEMVER[0]}" "${SEMVER[1]}" "${SEMVER[2]}" "$COMMIT_LIST")

if [[ "$CURRENT" == "$UPDATED_VERSION" ]] ; then
  echo "has no update"
  exit
fi

echo -n "$UPDATED_VERSION" >| ".api-version"