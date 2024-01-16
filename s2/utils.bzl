"Utils"

load("@aspect_bazel_lib//lib:repo_utils.bzl", "repo_utils")

def _platform_binary_name(ctx, prefix):
    return "%s%s" % (prefix, ".exe" if repo_utils.is_windows(ctx) else "")

def s2_toolchain_build_file(ctx, name, build_file):
    "Create a build file to put in a platform toolchain"
    ctx.template(
        "BUILD.bazel",
        build_file,
        substitutions = {
            "{name}": name,
            "{executable}": _platform_binary_name(ctx, name),
        },
    )

_S2_TOOLCHAINS_BUILD_FILE = """
toolchain(
    name = "{name}-{platform}_toolchain",
    toolchain = "@{prefix}-{platform}//:{name}_toolchain",
    exec_compatible_with = {exec_compatible_with},
    toolchain_type = "@bzlparty_rules_compress//s2:{name}_toolchain_type",
    visibility = ["//visibility:public"],
)

alias(
  name = "{name}-{platform}",
  actual = "@{prefix}-{platform}//:{name}",
)
"""

def s2_toolchains_build_file_snippet(**kwargs):
    return _S2_TOOLCHAINS_BUILD_FILE.format(**kwargs)
