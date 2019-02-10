#!/bin/sh

mkdir /root/.ssh
chmod 700 /root/.ssh

cp /secrets/git/targetgit-ssh-secret /root/.ssh/targetgit-ssh-secret
chmod 600 /root/.ssh/targetgit-ssh-secret
ssh-add /root/.ssh/targetgit-ssh-secret

git config --global user.email "you@example.com"
git config --global user.name "ci-robot"

cat <<\EOF >> ~/.ssh/config
Host $TARGET_REPO_NAME github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/targetgit-ssh-secret
EOF
chmod 400 ~/.ssh/config

ssh-keyscan -H github.com >> ~/.ssh/known_hosts

repository="git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git"
localFolder="/home/prow/go/src/github.com/$GITHUB_ORG_NAME/$TARGET_REPO_NAME"

git clone "$repository" "$localFolder"
