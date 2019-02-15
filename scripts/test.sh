#!/bin/bash
set -e

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}"

kubeval "${REPO_DIR}"/overlays/production/kustomization.yaml
echo "Kubeval Test successful"

PR-REF="$PULL_REFS"
if [ "$PR-REF" == "$(cat Pull_refs.txt)" ] ;then
    :
else
    echo "PR-REF didn't match"
fi