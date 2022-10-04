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

cd "$DIR/.."
NOW=$(date +%y.%m.%d_%H.%M.%S)

BUILD_DIR="$(pwd)/tmp/$(basename "${BASH_SOURCE[0]}")-${NOW}"
mkdir -p "$BUILD_DIR"

cd "$DIR/../.."

rm -rf "$BUILD_DIR/../.m2/com/essaid/fhir/hapi"

mvn "$@" -Dmaven.repo.local="$BUILD_DIR/../.m2" -DtrimStackTrace=false -Dsurefire_jvm_args="-Dfile.encoding=UTF-8 -Xmx4096m" -PALLMODULES,NOPARALLEL,PACKAGE_TESTS,_custom,DIST  clean install > "$BUILD_DIR/log.txt" 2>&1

# https://maven.apache.org/ref/3.6.3/maven-embedder/cli.html
# -fae,--fail-at-end	Only fail the build afterwards; allow all non-impacted builds to continue
# -ff,--fail-fast	Stop at first failure in reactorized builds
# -fn,--fail-never	NEVER fail the build, regardless of project result
