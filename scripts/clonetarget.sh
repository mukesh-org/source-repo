#!/bin/bash
set -e

TARGET_KEY_NAME=$(echo "$TARGET_SSH_PATH" | awk -F/ '{print $NF}')
export TARGET_KEY_NAME
echo "export TARGET_KEY_NAME=$TARGET_KEY_NAME" >> ~/.bashrc
source ~/.bashrc

cp "$TARGET_SSH_PATH" ~/.ssh/"$TARGET_KEY_NAME"
eval "$(ssh-agent)"
ssh-add ~/.ssh/"$TARGET_KEY_NAME"

cat <<EOF >> ~/.ssh/config
Host $TARGET_REPO_NAME github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/$TARGET_KEY_NAME
EOF
chmod 400 ~/.ssh/config

repository="git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git"
localFolder="/home/prow/go/src/github.com/$GITHUB_ORG_NAME/$TARGET_REPO_NAME"

git clone "$repository" "$localFolder"
echo "Target repo cloned successfully"

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

branch=source-PR-"$PULL_NUMBER"
git checkout -b "$branch"
echo "checked out to $branch branch"
