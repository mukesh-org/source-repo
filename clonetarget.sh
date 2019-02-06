#!/bin/sh

mkdir /root/.ssh
chmod 700 /root/.ssh

cp /secrets/flux/id_rsa /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-add /root/.ssh/id_rsa
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

repository="git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git"
localFolder="/home/prow/go/src/github.com/$GITHUB_ORG_NAME/$TARGET_REPO_NAME"

git clone "$repository" "$localFolder"
