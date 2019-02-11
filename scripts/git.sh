### Shell script for performing GitHub commands to merge content to PR named branch ###

#!/bin/sh
set -e

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}"

git remote add origin git@github.com:"$GITHUB_ORG_NAME"/"$TARGET_REPO_NAME".git

branch=$PULL_NUMBER

git checkout -b "$branch"
git add .
git commit -m 'kustomize file updated'
git push origin "$branch"
