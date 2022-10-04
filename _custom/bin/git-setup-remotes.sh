#!/usr/bin/env bash
#set -x
set -e
set -u
set -o pipefail
set -o noclobber
#set -f # no globbing
#shopt -s failglob # fail if glob doesn't expand

git remote remove hapi-fhir || true
git remote add --no-tags  hapi-fhir git@github.com:hapifhir/hapi-fhir.git
git config --add remote.hapi-fhir.fetch "+refs/tags/*:refs/rtags/hapi-fhir/*"

git remote remove hapi-fhir-fork || true
git remote add --no-tags  hapi-fhir-fork git@github.com:ShahimEssaid/hapi-fhir-fork.git
git config --add remote.hapi-fhir-fork.fetch "+refs/tags/*:refs/rtags/hapi-fhir-fork/*"

echo "Git setup remotes done!  Do fetch to update local content."

