#!/bin/sh

mkdir /root/.ssh
chmod 700 /root/.ssh

cp /secrets/git/target_ssh_secret /root/.ssh/target_ssh_secret
chmod 600 /root/.ssh/target_ssh_secret
ssh-add /root/.ssh/target_ssh_secret

cat <<\EOF >> ~/.ssh/config
Host $TARGET_REPO_NAME github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/target_ssh_secret
EOF
chmod 400 ~/.ssh/config

ssh-keyscan -H github.com >> ~/.ssh/known_hosts

repository="git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git"
localFolder="/home/prow/go/src/github.com/$GITHUB_ORG_NAME/$TARGET_REPO_NAME"

git clone "$repository" "$localFolder"
