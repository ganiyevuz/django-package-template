#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1:-}" ]; then
    echo "Usage: ./scripts/release.sh <version>"
    echo "Example: ./scripts/release.sh 0.2.0"
    exit 1
fi

VERSION="$1"
TAG="v${VERSION}"

# Validate clean working tree
if [ -n "$(git status --porcelain)" ]; then
    echo "Error: working tree is not clean. Commit or stash changes first."
    exit 1
fi

# Update version in pyproject.toml
sed -i '' "s/^version = \".*\"/version = \"${VERSION}\"/" pyproject.toml

# Find and update __version__ in any package under src/
INIT_FILE=$(find src -name '__init__.py' -path '*/src/*/__init__.py' -maxdepth 2 | head -1)
if [ -z "$INIT_FILE" ]; then
    echo "Error: no package __init__.py found under src/"
    exit 1
fi
sed -i '' "s/^__version__ = \".*\"/__version__ = \"${VERSION}\"/" "$INIT_FILE"

# Check if tag already exists
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo "Tag ${TAG} already exists."
    read -rp "Replace it with current code? (y/N): " CONFIRM
    if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
        echo "Aborted."
        exit 1
    fi
    git tag -d "${TAG}"
    git push origin ":refs/tags/${TAG}" 2>/dev/null || true
fi

# Commit, tag, push
git add pyproject.toml "$INIT_FILE"
git commit -m "release ${TAG}"
git tag -a "${TAG}" -m "Release ${TAG}"
git push origin main "${TAG}"

echo "Released ${TAG}"
echo "CI will build and publish to PyPI automatically."
