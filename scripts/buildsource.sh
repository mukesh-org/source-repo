#!/bin/bash
set -e

gcloud auth activate-service-account --key-file /secrets/gcloud/skaffold-secret.json
gcloud auth configure-docker
#need to get cluster credentials.
sed -i "s/SKAFFOLD_BUCKET_NAME/${skaffold_bucket_name}/g" skaffold.yaml
./scripts/clonetarget.sh
skaffold run
