#!/bin/bash

set -x

if [ "x`which jq`" == "x" ]; then
  echo "jq is required to use this script"
  exit 10
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 TAG_NAME"
  exit 1
fi

if [ "x${GITHUB_ACCESS_TOKEN}" == "x" ]; then
  echo "GITHUB_ACCESS_TOKEN env var must be set for authentication"
  exit 5
fi

TAG_NAME=$1
PRERELEASE=false

`echo $TAG_NAME | grep -q "rc"`
if [ $? -eq 0 ]; then
  PRERELEASE="true"
fi

STASH_RESULTS=`git stash -u`
VERSION_FILE="bitcurator/VERSION"

if [ "`cat ${VERSION_FILE}`" != "${TAG_NAME}" ]; then
  echo "==> Updating Release Version"
  rm -f ${VERSION_FILE}
  echo "$TAG_NAME" > ${VERSION_FILE}
  git add ${VERSION_FILE}
  git commit -m "Updating VERSION to $TAG_NAME"
  git push origin main

  echo "==> Tagging Repository"
  git tag $TAG_NAME

  echo "==> Pushing Tags to Remote"
  git push origin --tags

  echo "==> Sleeping, waiting for zip file"
  sleep 3
fi

echo "==> Creating GitHub Release"
RELEASE_ID=`curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -q https://api.github.com/repos/digitalsleuth/bitcurator-win-salt/releases -d "{\"tag_name\": \"$TAG_NAME\", \"prerelease\": $PRERELEASE}" | jq .id`
#RELEASE_ID=`curl -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" -q https://api.github.com/repos/digitalsleuth/bitcurator-win-salt/releases | jq -r ".[] | select(.tag_name == \"${TAG_NAME}\") | .id"`

if [[ -z $RELEASE_ID ]]
then
  echo "==> Release ID is null, aborting"
  exit 1
else
  echo "==> Release ID is ${RELEASE_ID}, continuing"
fi

echo "==> Downloading zip file for tag from GitHub"
curl -qL -o /tmp/bitcurator-win-salt-${TAG_NAME}.zip https://github.com/digitalsleuth/bitcurator-win-salt/archive/$TAG_NAME.zip

echo "==> Generating SHA256 of zip"
sha256sum /tmp/bitcurator-win-salt-$TAG_NAME.zip > /tmp/bitcurator-win-salt-$TAG_NAME.zip.sha256

echo "==> Generating GPG Signature of SHA256"
gpg --armor --clearsign --digest-algo SHA256 -u 4CF992E3 /tmp/bitcurator-win-salt-$TAG_NAME.zip.sha256

echo "==> Generating GPG Signature of zip file"
gpg --armor --detach-sign -u 4CF992E3 /tmp/bitcurator-win-salt-$TAG_NAME.zip

echo "==> Confirming the hash value for /tmp/bitcurator-win-salt-$TAG_NAME.zip"
cat /tmp/bitcurator-win-salt-$TAG_NAME.zip.sha256
sha256sum -c /tmp/bitcurator-win-salt-$TAG_NAME.zip.sha256
if [[ $? -ne 0 ]]
then
  echo "==> Hashes did not match, aborting"
  exit 1
else
  echo "==> Hashes match, continuing"
fi

echo "==> Uploading bitcurator-win-salt-$TAG_NAME.zip.sha256"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/digitalsleuth/bitcurator-win-salt/releases/${RELEASE_ID}/assets?name=bitcurator-win-salt-${TAG_NAME}.zip.sha256" --data-binary @/tmp/bitcurator-win-salt-$TAG_NAME.zip.sha256

echo "==> Uploading bitcurator-win-salt-$TAG_NAME.zip.sha256.asc"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/digitalsleuth/bitcurator-win-salt/releases/${RELEASE_ID}/assets?name=bitcurator-win-salt-${TAG_NAME}.zip.sha256.asc" --data-binary @/tmp/bitcurator-win-salt-$TAG_NAME.zip.sha256.asc

echo "==> Uploading bitcurator-win-salt-$TAG_NAME.zip.asc"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/digitalsleuth/bitcurator-win-salt/releases/${RELEASE_ID}/assets?name=bitcurator-win-salt-${TAG_NAME}.zip.asc" --data-binary @/tmp/bitcurator-win-salt-$TAG_NAME.zip.asc

rm /tmp/bitcurator-win-salt-${TAG_NAME}.zip
rm /tmp/bitcurator-win-salt-$TAG_NAME.zip.sha256
rm /tmp/bitcurator-win-salt-$TAG_NAME.zip.sha256.asc
rm /tmp/bitcurator-win-salt-$TAG_NAME.zip.asc

if [ "${STASH_RESULTS}" != "No local changes to save" ]; then
  git stash pop
fi
echo
