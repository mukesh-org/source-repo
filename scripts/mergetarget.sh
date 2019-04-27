### Shell script for performing GitHub merge source-PR-$PULL_NUMBER --> master branch ###
#!/bin/bash
set -e

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

branch=source-PR-"$PULL_NUMBER"

target_pull_refs="$(cat Pull_refs.txt)"
# echo sleep 60 sec
# sleep 60

if [ "$PULL_REFS" == "$target_pull_refs" ]
then
    echo "PR-REF matched successfully. Proceeding with $branch merge"
    git checkout master
    # git merge --ff-only origin $branch || (echo "cannot fast-forward" && exit 1)
    # git rebase $branch || (echo "cannot rebase" && exit 1)
    (
    git rebase $branch && echo "rebase with master performed"
    ) || (
    git rebase --skip && echo "skipped the conflicts in $branch"
    )
    git status
    git push -u origin master
    echo "$branch Merged successfully to master"
else
    echo "$branch"-PR_REF="$target_pull_refs"
    echo Actual-PR_REF="$PULL_REFS"
    echo "PR-REF didn't match. either wait for build to finish or rerun the build-job followed by /approve"
    exit 1
fi
