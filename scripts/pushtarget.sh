### Shell script for performing GitHub commands to merge content to PR named branch ###

#!/bin/bash
set -e

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

echo "$PULL_REFS" > Pull_refs.txt
echo Actual-pull-ref="$PULL_REFS"
echo Pull_refs="$(cat Pull_refs.txt)"

branch=source-PR-"$PULL_NUMBER"

git checkout -b "$branch"
git add .
git status
git commit -m 'kustomize file and PULL_REF updated'
git pull origin "$branch"
git push origin "$branch"
echo "Code pushed successfully"
