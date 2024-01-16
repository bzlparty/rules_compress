"S2 Toolchain"

load("@aspect_bazel_lib//lib:repo_utils.bzl", "repo_utils")
load("@bzlparty_tools//lib:github.bzl", "github")
load("@bzlparty_tools//lib:platforms.bzl", "PLATFORMS")
load(":artifacts.bzl", "ARTIFACTS", "VERSION")

S2Info = provider(
    doc = "S2 Toolchain Provider",
    fields = {
        "executable": "S2 Compress executable",
    },
)

_S2_REPOSITORY_BUILD_FILE = """# generated from //s2:toolchain.bzl
load("@bzlparty_rules_compress//s2:toolchain.bzl", "s2_toolchain")
exports_files(["{executable}"], visibility = ["//visibility:public"])
s2_toolchain(
    name = "{name}_toolchain",
    executable = "{executable}",
    visibility = ["//visibility:public"],
)
"""

_S2_TOOLCHAINS_BUILD_FILE = """
toolchain(
    name = "{name}-{platform}_toolchain",
    toolchain = "@{prefix}-{platform}//:{name}_toolchain",
    exec_compatible_with = {exec_compatible_with},
    toolchain_type = "@bzlparty_rules_compress//s2:{name}_toolchain_type",
    visibility = ["//visibility:public"],
)
"""

def _platform_binary_name(ctx, prefix):
    return "%s%s" % (prefix, ".exe" if repo_utils.is_windows(ctx) else "")

def _s2_toolchain_build_file(ctx, name):
    ctx.file("BUILD.bazel", _S2_REPOSITORY_BUILD_FILE.format(
        name = name,
        executable = _platform_binary_name(ctx, name),
    ))

def _s2_toolchain_repo_impl(ctx):
    platform = ctx.attr.platform
    version = ctx.attr.version
    (asset, integrity) = ARTIFACTS[platform]
    gh = github(ctx, orga = "klauspost", project = "compress")

    gh.download_archive(version, asset, integrity = integrity)

    _s2_toolchain_build_file(ctx, "s2c")

s2_toolchain_repo = repository_rule(
    _s2_toolchain_repo_impl,
    attrs = {
        "platform": attr.string(values = ARTIFACTS.keys(), mandatory = True),
        "version": attr.string(mandatory = True),
    },
)

def s2_platform_toolchains(name, platforms = ARTIFACTS.keys(), version = VERSION):
    """Macro to prepare all toolchains

    Args:
      name: uniqe name
      platforms: platforms to use
      version: s2 version
    """
    toolchains_build_file = ""
    for platform in platforms:
        s2_toolchain_repo(
            name = "%s-%s" % (name, platform),
            platform = platform,
            version = version,
        )
        toolchains_build_file += _S2_TOOLCHAINS_BUILD_FILE.format(
            name = "s2c",
            prefix = name,
            platform = platform,
            exec_compatible_with = PLATFORMS[platform],
        )

    s2_toolchains_repo(
        name = "%s_toolchains" % name,
        build_file = toolchains_build_file,
    )

def _s2_toolchains_repo(ctx):
    ctx.file("BUILD.bazel", ctx.attr.build_file)

s2_toolchains_repo = repository_rule(
    _s2_toolchains_repo,
    attrs = {
        "build_file": attr.string(mandatory = True),
    },
)

def _s2_toolchain_impl(ctx):
    executable = ctx.file.executable
    default_info = DefaultInfo(
        files = depset([executable]),
        runfiles = ctx.runfiles(files = [executable]),
    )
    s2_info = S2Info(
        executable = executable,
    )
    toolchain_info = platform_common.ToolchainInfo(
        s2_info = s2_info,
        default = default_info,
    )

    return [default_info, toolchain_info]

s2_toolchain = rule(
    _s2_toolchain_impl,
    attrs = {
        "executable": attr.label(allow_single_file = True),
    },
)
