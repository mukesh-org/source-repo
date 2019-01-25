#!/bin/sh

mkdir /root/.ssh
chmod 700 /root/.ssh

cp /secrets/repo-key/ssh-secret /root/.ssh/id_rsa1
chmod 600 /root/.ssh/id_rsa1
ssh-add ~/.ssh/id_rsa1

cat <<\EOF >> ~/.ssh/config
#source repo
Host github.com-mukesh-org/"$REPO_NAME"
	HostName github.com
	User git
	IdentityFile ~/.ssh/id_rsa1
EOF

git remote add origin git@github.com:mukesh-org/"$REPO_NAME".git
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

branch=development

## resolve any merge conflicts if there are any
git fetch origin master
git merge FETCH_HEAD

git checkout master
git merge --no-ff "$branch"
git push -u origin master
