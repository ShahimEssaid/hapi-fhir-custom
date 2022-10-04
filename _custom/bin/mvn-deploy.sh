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

BUILD_ENV=
if [[ -v GITHUB_ACTIONS ]]; then
    BUILD_ENV=gha_
fi


if "$DIR/set-deploy-version.sh" $BUILD_ENV; then
   mvn deploy -PALLMODULES,PACKAGE_TESTS,_custom,DIST  -DskipTests
   mvn versions:revert -DprocessAllModules
else
   echo Deploy not done due error while setting deploy version. Exiting 1.
   exit 1
fi



# https://maven.apache.org/ref/3.6.3/maven-embedder/cli.html
# -fae,--fail-at-end	Only fail the build afterwards; allow all non-impacted builds to continue
# -ff,--fail-fast	Stop at first failure in reactorized builds
# -fn,--fail-never	NEVER fail the build, regardless of project result
