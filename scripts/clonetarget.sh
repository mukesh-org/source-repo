#!/bin/sh
set -e

cp /secrets/git/targetgit-ssh-secret /root/.ssh/targetgit-ssh-secret
chmod 600 /root/.ssh/targetgit-ssh-secret
eval $(ssh-agent)
ssh-add /root/.ssh/targetgit-ssh-secret

cat <<\EOF >> ~/.ssh/config
Host $TARGET_REPO_NAME github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/targetgit-ssh-secret
EOF
chmod 400 ~/.ssh/config

repository="git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git"
localFolder="/home/prow/go/src/github.com/$GITHUB_ORG_NAME/$TARGET_REPO_NAME"

git clone "$repository" "$localFolder"