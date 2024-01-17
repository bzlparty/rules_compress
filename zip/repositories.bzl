"Repositories"

load("@bzlparty_tools//lib:github.bzl", "github")
load(":assets.bzl", "ASSETS", "PLATFORMS", "VERSION")
load(":utils.bzl", "executable_target", "zip_toolchain_build_file")

def zip_platform_toolchains(name, platforms = PLATFORMS.keys(), version = VERSION):
    """Macro to prepare all toolchains

    Args:
      name: uniqe name
      platforms: platforms to use
      version: zip version
    """
    for platform in platforms:
        zip_toolchain_repo(
            name = "%s-%s" % (name, platform),
            platform = platform,
            version = version,
            executable = executable_target("7zz", platform),
        )

    zip_toolchains_repo(
        name = "%s_toolchains" % name,
        executable = "7zz",
    )

def _is_windows(platform):
    return platform.startswith("windows")

def _zip_toolchain_repo_impl(ctx):
    platform = ctx.attr.platform
    version = ctx.attr.version
    executable = ctx.attr.executable
    (asset, integrity) = ASSETS[platform]
    gh = github(ctx, orga = "ip7z", project = "7zip")

    if _is_windows(platform):
        gh.download_binary(version, asset, integrity = integrity, output = executable)
    else:
        gh.download_archive(version, asset, integrity = integrity)

    zip_toolchain_build_file(ctx, ctx.attr._build_file, substitutions = {
        "EXECUTABLE": executable,
    })

zip_toolchain_repo = repository_rule(
    _zip_toolchain_repo_impl,
    attrs = {
        "platform": attr.string(
            values = PLATFORMS.keys(),
            mandatory = True,
        ),
        "version": attr.string(
            mandatory = True,
        ),
        "executable": attr.string(),
        "_build_file": attr.label(
            allow_single_file = True,
            default = Label("//zip:toolchain.BUILD.bazel"),
        ),
    },
)

def _zip_toolchains_repo(ctx):
    platform = "%s_%s" % (ctx.os.name, ctx.os.arch)
    zip_toolchain_build_file(
        ctx,
        ctx.attr._build_file,
        substitutions = {
            "EXECUTABLE": executable_target(ctx.attr.executable, platform),
            "HOST_PLATFORM": platform,
        },
    )

zip_toolchains_repo = repository_rule(
    _zip_toolchains_repo,
    attrs = {
        "executable": attr.string(),
        "_build_file": attr.label(default = Label("//zip:toolchains.BUILD.bazel")),
    },
)
