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

repository="git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git"
localFolder="/home/prow/go/src/github.com/$GITHUB_ORG_NAME/$TARGET_REPO_NAME"

git clone "$repository" "$localFolder"
