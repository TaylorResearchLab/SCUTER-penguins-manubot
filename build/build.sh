#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

export TZ=Etc/UTC
export LC_ALL=en_US.UTF-8

BUILD_PDF="${BUILD_PDF:-true}"
PANDOC_DATA_DIR="${PANDOC_DATA_DIR:-build/pandoc}"

mkdir -p output ci/cache content/images

echo >&2 "Retrieving and processing reference metadata"
manubot process \
  --content-directory=content \
  --output-directory=output \
  --cache-directory=ci/cache \
  --skip-citations \
  --log-level=INFO

echo >&2 "Exporting HTML manuscript"
pandoc --verbose \
  --data-dir="$PANDOC_DATA_DIR" \
  --defaults=common.yaml \
  --defaults=html.yaml

if [ "$BUILD_PDF" != "false" ]; then
  echo >&2 "Exporting PDF manuscript using WeasyPrint"
  CLEAN_IMAGE_LINK=false
  if [ ! -e images ]; then
    ln -s content/images images
    CLEAN_IMAGE_LINK=true
  fi
  pandoc \
    --data-dir="$PANDOC_DATA_DIR" \
    --defaults=common.yaml \
    --defaults=html.yaml \
    --defaults=pdf-weasyprint.yaml
  if [ "$CLEAN_IMAGE_LINK" = "true" ]; then
    rm images
  fi
fi

echo >&2 "Build complete"
