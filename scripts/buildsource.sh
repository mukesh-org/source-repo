#!/bin/bash
set -e

## Gcloud for docker auth and generating kubeconfig file
gcloud auth activate-service-account --key-file "$GOOGLE_APPLICATION_CREDENTIALS"
gcloud auth configure-docker
gcloud container clusters get-credentials "$CLUSTER_NAME" --zone "$ZONE_NAME" --project "$PROJECT_ID"

## Need to clone before skaffold run, so that kustomize manifest can be stored in target-repo dir
./scripts/clonetarget.sh

REPO_DIR=../"$REPO_NAME"
cd "${REPO_DIR}" || exit
sed -i "s/SKAFFOLD_BUCKET_NAME/$SKAFFOLD_CONTEXT_UPLOAD/g" skaffold.yaml
skaffold run

REPO_DIR=../"$TARGET_REPO_NAME"
cd "${REPO_DIR}" || exit
./scripts/pushtarget.sh
