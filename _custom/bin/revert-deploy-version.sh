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

if [ -f pom.xml.versionsBackup ]; then
   mvn versions:revert -DprocessAllModules
else
   echo No backup version to revert to. Exiting 1.
   exit 1
fi


