"Repositories"

load("@bzlparty_tools//lib:github.bzl", "github")
load(":artifacts.bzl", "ARTIFACTS", "PLATFORMS", "VERSION")
load(":utils.bzl", "s2_toolchain_build_file", "s2_toolchains_build_file_snippet")

def s2_platform_toolchains(name, platforms = PLATFORMS.keys(), version = VERSION):
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
        toolchains_build_file += s2_toolchains_build_file_snippet(
            name = "s2c",
            prefix = name,
            platform = platform,
            exec_compatible_with = PLATFORMS[platform],
        )

    s2_toolchains_repo(
        name = "%s_toolchains" % name,
        build_file = toolchains_build_file,
    )

def _s2_toolchain_repo_impl(ctx):
    platform = ctx.attr.platform
    version = ctx.attr.version
    (asset, integrity) = ARTIFACTS[platform]
    gh = github(ctx, orga = "klauspost", project = "compress")

    gh.download_archive(version, asset, integrity = integrity)

    s2_toolchain_build_file(ctx, "s2c", ctx.attr._build_file)

s2_toolchain_repo = repository_rule(
    _s2_toolchain_repo_impl,
    attrs = {
        "platform": attr.string(values = PLATFORMS.keys(), mandatory = True),
        "version": attr.string(mandatory = True),
        "_build_file": attr.label(allow_single_file = True, default = Label("//s2:toolchain.BUILD.bazel")),
    },
)

def _s2_toolchains_repo(ctx):
    ctx.file("BUILD.bazel", ctx.attr.build_file)

s2_toolchains_repo = repository_rule(
    _s2_toolchains_repo,
    attrs = {
        "build_file": attr.string(mandatory = True),
    },
)
