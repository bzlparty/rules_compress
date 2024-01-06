"S2 Toolchain"

load("@aspect_bazel_lib//lib:repo_utils.bzl", "repo_utils")
load("@bzlparty_tools//lib:github.bzl", "github")
load(":artifacts.bzl", "ARTIFACTS", "VERSION")

S2BinaryInfo = provider(
    doc = "S2 Toolchain Provider",
    fields = {
        "s2c_binary": "S2 Compress executable",
        "s2sx_binary": "S2 Compress Self-extractable executable",
    },
)

_S2_REPOSITORY_BUILD_FILE = """# generated from //bundler:extensions.bzl
load("@bzlparty_rules_compress//s2:toolchain.bzl", "s2_toolchain")
s2_toolchain(
    name = "s2_toolchain",
    s2c_binary = "{s2c_binary}",
    s2sx_binary = "{s2sx_binary}",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "toolchain",
    toolchain = ":s2_toolchain",
    toolchain_type = "@bzlparty_rules_compress//s2:toolchain_type",
)
"""

def _platform_binary_name(ctx, prefix):
    return "%s%s" % (prefix, ".exe" if repo_utils.is_windows(ctx) else "")

def _s2_toolchain_build_file(ctx):
    ctx.file("BUILD.bazel", _S2_REPOSITORY_BUILD_FILE.format(
        s2c_binary = _platform_binary_name(ctx, "s2c"),
        s2sx_binary = _platform_binary_name(ctx, "s2sx"),
    ))

def _s2_toolchain_repo_impl(ctx):
    platform = repo_utils.platform(ctx)
    (archive, integrity) = ARTIFACTS[platform]
    gh = github(ctx, orga = "klauspost", project = "compress")

    gh.download_archive(VERSION, archive, integrity = integrity)

    _s2_toolchain_build_file(ctx)

s2_toolchain_repo = repository_rule(
    _s2_toolchain_repo_impl,
)

def _s2_toolchain_impl(ctx):
    s2c_binary = ctx.file.s2c_binary
    s2sx_binary = ctx.file.s2sx_binary
    default_info = DefaultInfo(
        files = depset([s2c_binary, s2sx_binary]),
        runfiles = ctx.runfiles(files = [s2c_binary, s2sx_binary]),
    )
    s2_info = S2BinaryInfo(
        s2c_binary = s2c_binary,
        s2sx_binary = s2sx_binary,
    )
    toolchain_info = platform_common.ToolchainInfo(
        s2_info = s2_info,
        default = default_info,
    )

    return [default_info, toolchain_info]

s2_toolchain = rule(
    _s2_toolchain_impl,
    attrs = {
        "s2c_binary": attr.label(allow_single_file = True),
        "s2sx_binary": attr.label(allow_single_file = True),
    },
)
