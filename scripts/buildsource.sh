#!/bin/bash
set -e

gcloud auth activate-service-account --key-file /secrets/gcloud/skaffold-secret.json
gcloud auth configure-docker

./clonetarget.sh

REPO_DIR=../"$REPO_NAME"
cd "${REPO_DIR}" || exit

sed -i "s/SKAFFOLD_BUCKET_NAME/${skaffold_bucket_name}/g" skaffold.yaml
skaffold run
