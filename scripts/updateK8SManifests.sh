#!/bin/bash

set -ex

: "${AZURE_DEVOPS_ORG:?Need to set AZURE_DEVOPS_ORG}"
: "${AZURE_DEVOPS_PAT:?Need to set AZURE_DEVOPS_PAT}"
: "${AZURE_DEVOPS_PROJECT:?Need to set AZURE_DEVOPS_PROJECT}"
: "${AZURE_DEVOPS_REPO:?Need to set AZURE_DEVOPS_REPO}"

REPO_URL="https://${AZURE_DEVOPS_ORG}:${AZURE_DEVOPS_PAT}@dev.azure.com/${AZURE_DEVOPS_ORG}/${AZURE_DEVOPS_PROJECT}/_git/${AZURE_DEVOPS_REPO}"

rm -rf /tmp/temp_repo/*

git clone "$REPO_URL" /tmp/temp_repo

cd /tmp/temp_repo

sed -i "s|image:.*|image: azeacrpdpipe-byexc2gcdkg7auf6.azurecr.io/$2:$3|g" K8S/$1-deployment.yml

git add .

git commit -m "Update Kubernetes manifest to $2:$3"

git push

rm -rf /tmp/temp_repo