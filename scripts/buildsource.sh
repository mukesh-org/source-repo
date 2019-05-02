#!/bin/bash
set -e

## Gcloud for docker auth and generating kubeconfig file
gcloud auth activate-service-account --key-file "$GOOGLE_APPLICATION_CREDENTIALS"
gcloud auth configure-docker
gcloud container clusters get-credentials "$CLUSTER_NAME" --zone "$ZONE_NAME" --project "$PROJECT_ID"

## Need to clone before skaffold run, so that kustomize manifest can be stored in target-repo dir
./scripts/clonetarget.sh

## Running Skaffold inside source-repo
sed -i "s/SKAFFOLD_BUCKET_NAME/$SKAFFOLD_CONTEXT_UPLOAD/g" skaffold.yaml
sed -i "s/PROJECT_ID/$PROJECT_ID/g" skaffold.yaml

branch=source-PR-"$PULL_NUMBER"

skaffold run

## Git Push the kustomize files to target-repo
REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

echo "$PULL_REFS" > Pull_refs.txt
echo Actual-PULL_REFS="$PULL_REFS"
echo "========== Performing Git Operations ============="
git add -A
git status
echo "========== Modified files staged, moving with rebase continue =========="
sleep 60m
(git rebase --continue && echo "git rebase continued") || (git commit -m "kustomize and PULL_REF file updated for $branch")
echo "========== Rebase complete, pushing changes to remote ============"
git push --force-with-lease origin "$branch"
echo "========== Code pushed successfully to $branch ============"

## Test the YAML file generated using Kubeval
REPO_DIR=../"$REPO_NAME"
cd "${REPO_DIR}" || exit

./scripts/testtarget.sh
