#!/bin/bash

set -ex

PREV_VERSION=$(git describe --match="v*" --tags --abbrev=0)
git log --pretty=format:"%h %s" --no-merges --invert-grep "$PREV_VERSION..HEAD"