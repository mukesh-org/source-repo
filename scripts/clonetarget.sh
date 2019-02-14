#!/bin/sh
set -e

TARGET_KEY_NAME=$(echo "$TARGET_SSH_PATH" | awk -F/ '{print $NF}')
export TARGET_KEY_NAME
echo "export TARGET_KEY_NAME=$TARGET_KEY_NAME" >> ~/.bashrc

cp "$TARGET_SSH_PATH" ~/.ssh/"$TARGET_KEY_NAME"
eval "$(ssh-agent)"
ssh-add ~/.ssh/"$TARGET_KEY_NAME"

cat <<\EOF >> ~/.ssh/config
Host $TARGET_REPO_NAME github.com
	HostName github.com
	User git
	IdentityFile ~/.ssh/$TARGET_KEY_NAME
EOF
chmod 400 ~/.ssh/config

repository="git@github.com:$GITHUB_ORG_NAME/$TARGET_REPO_NAME.git"
localFolder="/home/prow/go/src/github.com/$GITHUB_ORG_NAME/$TARGET_REPO_NAME"

git clone "$repository" "$localFolder"
