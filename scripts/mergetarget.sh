### Shell script for performing GitHub merge source-PR-$PULL_NUMBER --> master branch ###
#!/bin/bash
set -e

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

branch=source-PR-"$PULL_NUMBER"

## resolve any merge conflicts if there are any
git pull origin $branch
git checkout master
git merge --no-ff --no-commit "$branch"
git status
git commit -m "merge $branch branch"
git push -u origin master
echo "$branch Merged successfully to master"
