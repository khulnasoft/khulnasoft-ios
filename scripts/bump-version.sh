#!/bin/bash

# ./scripts/bump-version.sh <new version>
# eg ./scripts/bump-version.sh "3.0.0-alpha.1"

set -eux

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR/..

NEW_VERSION="$1"

# Replace `khulnaSoftVersion` with the given version
perl -pi -e "s/khulnaSoftVersion = \".*\"/khulnaSoftVersion = \"$NEW_VERSION\"/" KhulnaSoft/KhulnaSoftVersion.swift

# Replace `s.version` with the given version
perl -pi -e "s/s.version          = \".*\"/s.version          = \"$NEW_VERSION\"/" KhulnaSoft.podspec
