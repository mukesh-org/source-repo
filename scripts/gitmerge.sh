### Shell script for performing GitHub merge PR branch to master branch ###

#!/bin/sh
set -e

eval $(ssh-agent)
ssh-add "$TARGET_SSH_PATH"

cat <<\EOF >> ~/.ssh/config
Host $TARGET_REPO_NAME github.com
	HostName github.com
	User git
	IdentityFile $TARGET_SSH_PATH
EOF
chmod 400 ~/.ssh/config

branch="$PULL_NUMBER"

## resolve any merge conflicts if there are any
git checkout "$branch"
git pull
git checkout master
git merge --no-ff --no-commit "$branch"
git status
git commit -m "merge $branch branch"
git push -u origin master
