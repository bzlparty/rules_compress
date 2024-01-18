"Repositories"

load("@bzlparty_tools//lib:github.bzl", "github")
load("//utils:toolchain.bzl", "toolchain_build_file")
load(":assets.bzl", "ASSETS", "PLATFORMS", "VERSION")

def s2_platform_toolchains(name, platforms = PLATFORMS.keys(), version = VERSION):
    """Macro to prepare all toolchains

    Args:
      name: uniqe name
      platforms: platforms to use
      version: s2 version
    """
    for platform in platforms:
        s2_toolchain_repo(
            name = "%s-%s" % (name, platform),
            platform = platform,
            version = version,
        )

    s2_toolchains_repo(name = "%s_toolchains" % name)

def _s2_toolchain_repo_impl(ctx):
    platform = ctx.attr.platform
    version = "v%s" % ctx.attr.version
    (asset, integrity) = ASSETS[platform]
    gh = github(ctx, orga = "klauspost", project = "compress")

    gh.download_archive(version, asset, integrity = integrity)

    toolchain_build_file(ctx, substitutions = {
        "EXECUTABLE": "s2c",
    })

s2_toolchain_repo = repository_rule(
    _s2_toolchain_repo_impl,
    attrs = {
        "platform": attr.string(values = PLATFORMS.keys(), mandatory = True),
        "version": attr.string(mandatory = True),
        "_build_file": attr.label(allow_single_file = True, default = Label("//s2:toolchain.BUILD.bazel")),
    },
)

def _s2_toolchains_repo(ctx):
    toolchain_build_file(ctx, substitutions = {
        "EXECUTABLE": "s2c",
    })

s2_toolchains_repo = repository_rule(
    _s2_toolchains_repo,
    attrs = {
        "_build_file": attr.label(default = "//s2:toolchains.BUILD.bazel"),
    },
)
