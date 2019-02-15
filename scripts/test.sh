#!/bin/bash
set -e

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit

PR-REF="$PULL_REFS"
if [ "$PR-REF" == "$(cat Pull_refs.txt)" ] ;then
    echo "PR-REF matched successfully. Proceeding with YAML test"
    kubeval "${REPO_DIR}"/overlays/production/kustomization.yaml
    echo "Kubeval Test successful"
else
    echo "PR-REF didn't match. wait for build job to finish and RE-RUN test job"
fi