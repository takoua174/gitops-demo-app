#!/usr/bin/env bash
# Usage: GITHUB_USER=youruser GITHUB_PAT=ghp_xxx ./push-all.sh
set -euo pipefail
USER_LC=$(echo "$GITHUB_USER" | tr '[:upper:]' '[:lower:]')   # GHCR needs lowercase
IMAGE="ghcr.io/${USER_LC}/gitops-demo-app"

echo "$GITHUB_PAT" | docker login ghcr.io -u "$GITHUB_USER" --password-stdin

for V in 1.0.0 1.1.0 1.2.0; do
  sed -i.bak "s/^ENV APP_VERSION=.*/ENV APP_VERSION=${V}/" Dockerfile && rm -f Dockerfile.bak
  docker build -t "${IMAGE}:${V}" .
  docker push "${IMAGE}:${V}"
done

# leave Dockerfile at the first version
sed -i.bak "s/^ENV APP_VERSION=.*/ENV APP_VERSION=1.0.0/" Dockerfile && rm -f Dockerfile.bak
