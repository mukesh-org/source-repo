### Shell script for performing GitHub merge source-PR-$PULL_NUMBER --> master branch ###
#!/bin/bash
set -e

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

branch=source-PR-"$PULL_NUMBER"

target_pull_refs="$(cat Pull_refs.txt)"

if [ "$PULL_REFS" == "$target_pull_refs" ]
then
    echo "==== PR-REF matched successfully. Proceeding with $branch fast-forward merge ===="
    git checkout master
    git merge --ff-only $branch || (echo "==== $branch cannot fast-forward ====" && exit 1)
    git status
    git push -u origin master
    echo "==== $branch merged and pushed successfully to master ===="
else
    echo "$branch"-PR_REF="$target_pull_refs"
    echo Actual-PR_REF="$PULL_REFS"
    echo "==== PR-REF didn't match. Either wait for build to finish or RE-RUN the build by /build followed by /approve ===="
    exit 1
fi
