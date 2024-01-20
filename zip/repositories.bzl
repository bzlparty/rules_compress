"Repositories"

load("@bzlparty_tools//lib:github.bzl", "github")
load("@bzlparty_tools//lib:platforms.bzl", "is_windows")
load("//utils:repositories.bzl", "combined_toolchains_repo", "compress_toolchain_repo")
load(":assets.bzl", "ASSETS", "PLATFORMS", "VERSION")

def zip_platform_toolchains(name, platforms = PLATFORMS.keys(), version = VERSION):
    """Macro to prepare all toolchains

    Args:
      name: uniqe name
      platforms: platforms to use
      version: zip version
    """
    for platform in platforms:
        _zip_toolchain_repo(
            name = "%s-%s" % (name, platform),
            platform = platform,
            version = version,
            build_file = "//zip/private:toolchain.BUILD.bazel",
        )

    combined_toolchains_repo(
        name = "%s_toolchains" % name,
        build_file = "//zip/private:toolchains.BUILD.bazel",
    )

def _zip_toolchain_repo_impl(ctx):
    platform = ctx.attr.platform
    version = ctx.attr.version
    (asset, integrity) = ASSETS[platform]
    gh = github(ctx, orga = "ip7z", project = "7zip")

    if is_windows(platform):
        gh.download_binary(version, asset, integrity = integrity, output = "7zz.exe")
    else:
        gh.download_archive(version, asset, integrity = integrity)

_zip_toolchain_repo = repository_rule(
    compress_toolchain_repo.implementor(_zip_toolchain_repo_impl),
    attrs = compress_toolchain_repo.attrs,
)
