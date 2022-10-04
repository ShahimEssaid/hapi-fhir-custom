#!/usr/bin/env bash
#set -x
set -e
set -u
set -o pipefail
set -o noclobber
#set -f # no globbing
#shopt -s failglob # fail if glob doesn't expand

# See http://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd "$DIR/../.."

CURRENT_VERSION=$(mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.version -q -DforceStdout)
CURRNET_BRANCH=$(git rev-parse --abbrev-ref HEAD)
NEW_VERSION=${CURRENT_VERSION}-${1-}${CURRNET_BRANCH//[!A-Za-z0-9]/_}-SNAPSHOT

echo Adjusting CURRENT_VERSION: $CURRENT_VERSION
echo CURRNET_BRANCH: $CURRNET_BRANCH
echo NEW_VERSION: $NEW_VERSION

if [ -f pom.xml.versionsBackup ]; then
   echo Reverting existing uncommitted version change.
   mvn versions:revert -DprocessAllModules
fi

if [ ! -f pom.xml.versionsBackup ]; then
   mvn versions:set -DnewVersion=${NEW_VERSION} -DprocessAllModules
else
   echo Version setting already in progress but not committed yet. Exiting 1.
   exit 1
fi


