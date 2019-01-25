#!/bin/sh

mkdir /root/.ssh
chmod 700 /root/.ssh
cp /secrets/flux/id_rsa /root/.ssh/id_rsa
cp /secrets/repo-key/ssh-secret /root/.ssh/id_rsa1
chmod 600 /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa1
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa1

Host me.github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/me_rsa

Host work.github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/work_rsa

git remote add origin git@github.com:mukesh-org/$REPO_NAME.git
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

BASE=development

## resolve any merge conflicts if there are any
git fetch origin master
git merge FETCH_HEAD

git checkout master
git merge --no-ff "$BASE"
git push -u origin master
