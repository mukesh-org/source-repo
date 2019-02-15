#!/bin/bash
set -e

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

branch=source-PR-"$PULL_NUMBER"
git checkout "$branch"
git pull origin "$branch"

target_pull_refs="$(cat Pull_refs.txt)"

echo TargetBranch-Pull_refs="$target_pull_refs"
echo Actual PR_REF="$PULL_REFS"

if [ "$PULL_REFS" == "$target_pull_refs" ] ;then
    echo "PR-REF matched successfully. Proceeding with YAML test"
    kubeval "${REPO_DIR}"/overlays/production/kustomization.yaml
    echo "Kubeval Test successful"
else
    echo "PR-REF didn't match. wait for build job to finish and RE-RUN test job"
fi