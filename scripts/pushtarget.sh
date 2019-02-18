### Shell script for performing GitHub push commands to merge content to "source-PR-named" branch ###
#!/bin/bash

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

echo "$PULL_REFS" > Pull_refs.txt
echo Actual-PULL_REFS="$PULL_REFS"

branch=source-PR-"$PULL_NUMBER"

git checkout -b "$branch"
git branch
echo "checked out to $branch branch"

git add -A
git status
git commit -m 'kustomize file and PULL_REF updated'
git push -f origin "$branch"
echo "Code pushed successfully"
