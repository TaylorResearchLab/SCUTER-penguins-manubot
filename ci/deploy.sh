#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

REPO_SLUG=${GITHUB_REPOSITORY}
COMMIT=${GITHUB_SHA}
BRANCH=${DEFAULT_BRANCH:-main}
OWNER_NAME="$(dirname "$REPO_SLUG")"
REPO_NAME="$(basename "$REPO_SLUG")"
export REPO_SLUG COMMIT OWNER_NAME REPO_NAME

envsubst < webpage/README.md > webpage/README-complete.md
mv webpage/README-complete.md webpage/README.md

git config --global push.default simple
git config --global user.email "$(git log --max-count=1 --format='%ae')"
git config --global user.name "$(git log --max-count=1 --format='%an')"
git checkout "$BRANCH"

git remote set-url origin "https://${MANUBOT_ACCESS_TOKEN}@github.com/${REPO_SLUG}.git"
git remote set-branches --add origin gh-pages output
git fetch origin gh-pages:gh-pages output:output || echo >&2 "[INFO] could not fetch gh-pages or output from origin."

manubot webpage \
  --timestamp \
  --no-ots-cache \
  --checkout=gh-pages \
  --version="$COMMIT"

MESSAGE="$(git log --max-count=1 --format='%s')
[ci skip]

This build is based on https://github.com/$REPO_SLUG/commit/$COMMIT.
CI build: $CI_BUILD_WEB_URL
CI job: $CI_JOB_WEB_URL"

ghp-import --push --branch=output --message="$MESSAGE" output
ghp-import --no-jekyll --follow-links --push --branch=gh-pages --message="$MESSAGE" webpage
