### Shell script for performing GitHub merge commands to master branch ###

#!/bin/sh

git remote add origin git@github.com:mukesh-org/$REPO_NAME.git
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

BASE=development

## resolve any merge conflicts if there are any
git fetch origin master
git merge FETCH_HEAD

git checkout master
git merge --no-ff "$BASE"
git push -u origin master
