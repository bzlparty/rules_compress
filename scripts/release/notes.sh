#!/usr/bin/env bash

DEST=${DEST:-dist}
TAG=${GITHUB_REF_NAME:-main}

NAME=rules_compress
ALGO=384
VERSION=$TAG
[[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.*)?$ ]] && VERSION=${TAG:1}
PREFIX="$NAME-$VERSION"
RULES_ARCHIVE="$NAME-$TAG".tar.gz
RULES_ARCHIVE_PATH="$DEST/$RULES_ARCHIVE"
RULES_SHA=$(< "$RULES_ARCHIVE_PATH".sha384)

cat <<EOF

## Installation

> [!IMPORTANT]  
> Installation is only supported via Bzlmod!

Choose from the options below and put as dependency in your \`MODULE.bazel\`.

### Install from BCR

\`\`\`starlark
bazel_dep(name = "bzlparty_$NAME", version = "${VERSION}")
\`\`\`

### Install from Archive

\`\`\`starlark
bazel_dep(name = "bzlparty_$NAME")

archive_override(
    module_name = "bzlparty_$NAME",
    urls = "https://github.com/bzlparty/$NAME/releases/download/${TAG}/${RULES_ARCHIVE}",
    strip_prefix = "${PREFIX}",
    integrity = "sha$ALGO-${RULES_SHA}",
)
\`\`\`

## Checksums

**${RULES_ARCHIVE}** sha$ALGO: $(< "$RULES_ARCHIVE".sha384)

EOF
