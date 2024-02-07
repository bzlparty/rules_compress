#!/usr/bin/env bash

host=$(uname -s)
NAME=rules_compress
TAG=${GITHUB_REF_NAME}
VERSION=${TAG:1}
PREFIX="${NAME}-${VERSION}"
RULES_ARCHIVE="${NAME}-${TAG}.tar.gz"

echo -n "build: Create Rules Archive"
build_dir=dist
git archive \
  --add-virtual-file=${PREFIX}/BUILD.bazel:"$(cat ${build_dir}/public.BUILD.bazel)" \
  --add-virtual-file=${PREFIX}/MODULE.bazel:"$(sed "s/VERSION/${VERSION}/" ${build_dir}/MODULE.bazel)" \
  --add-virtual-file=${PREFIX}/s2/BUILD.bazel:"$(cat ${build_dir}/s2.BUILD.bazel)" \
  --add-virtual-file=${PREFIX}/s2/private/BUILD.bazel:"$(cat ${build_dir}/private.BUILD.bazel)" \
  --add-virtual-file=${PREFIX}/zip/BUILD.bazel:"$(cat ${build_dir}/zip.BUILD.bazel)" \
  --add-virtual-file=${PREFIX}/zip/private/BUILD.bazel:"$(cat ${build_dir}/private.BUILD.bazel)" \
  --add-virtual-file=${PREFIX}/utils/BUILD.bazel:"$(cat ${build_dir}/public.BUILD.bazel)" \
  --format=tar \
  --prefix=${PREFIX}/ ${TAG} | gzip >$RULES_ARCHIVE
RULES_SHA=$(shasum -a 256 $RULES_ARCHIVE | awk '{print $1}')
echo " ... done ($RULES_ARCHIVE: $RULES_SHA)"

echo -n "build: Creaet Release Notes"
cat > release_notes.md <<EOF

## Installation

> [!IMPORTANT]  
> Installation is only supported via Bzlmod!

### Install from Git

\`\`\`starlark
bazel_dep(name = "bzlparty_rules_compress")

git_override(
    module_name = "bzlparty_rules_compress",
    remote = "https://github.com/bzlparty/rules_compress",
    commit = "${GITHUB_SHA}",
)
\`\`\`

### Install from Archive

\`\`\`starlark
bazel_dep(name = "bzlparty_rules_compress")

archive_override(
    module_name = "bzlparty_rules_compress",
    urls = "https://github.com/bzlparty/rules_compress/releases/download/${TAG}/${RULES_ARCHIVE}",
    strip_prefix = "${PREFIX}",
    integrity = "sha256-${RULES_SHA}",
)
\`\`\`

## Checksums

**${RULES_ARCHIVE}** ${RULES_SHA}

EOF

echo " ... done"
