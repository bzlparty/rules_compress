"Repositories"

load("@bzlparty_tools//lib:github.bzl", "github")
load("//utils:repositories.bzl", "combined_toolchains_repo", "compress_toolchain_repo")
load(":assets.bzl", "ASSETS", "PLATFORMS", "VERSION")

def s2_platform_toolchains(name, platforms = PLATFORMS.keys(), version = VERSION):
    """Macro to prepare all toolchains

    Args:
      name: uniqe name
      platforms: platforms to use
      version: s2 version
    """
    for platform in platforms:
        _s2_toolchain_repo(
            name = "%s-%s" % (name, platform),
            platform = platform,
            version = "v" + version,
            build_file = "//s2:toolchain.BUILD.bazel",
        )

    combined_toolchains_repo(
        name = "%s_toolchains" % name,
        build_file = "//s2:toolchains.BUILD.bazel",
    )

def _s2_toolchain_repo_impl(ctx):
    gh = github(ctx, orga = "klauspost", project = "compress")
    (asset, integrity) = ASSETS[ctx.attr.platform]

    gh.download_archive("v%s" % ctx.attr.version, asset, integrity = integrity)

_s2_toolchain_repo = repository_rule(
    compress_toolchain_repo.implementor(_s2_toolchain_repo_impl),
    attrs = compress_toolchain_repo.attrs,
)
