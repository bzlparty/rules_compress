"Repository Utils"

def compress_toolchains(name, assets):
    """Macro to prepare all toolchains

    Args:
      name: uniqe name
      assets: assets to use
    """
    for (platform, asset) in assets.items():
        _platform_toolchain(
            name = "%s_%s" % (name, platform),
            url = asset.url,
            integrity = asset.integrity,
            build_file = "//%s/private:toolchain.BUILD.bazel" % name,
        )

    _platform_toolchains(
        name = "%s_toolchains" % name,
        build_file = "//%s/private:toolchains.BUILD.bazel" % name,
    )

def _toolchain_build_file(ctx):
    ctx.template("BUILD.bazel", ctx.attr.build_file, executable = False)

def _platform_toolchain_impl(ctx):
    ctx.download_and_extract(
        url = ctx.attr.url,
        integrity = ctx.attr.integrity,
    )

    _toolchain_build_file(ctx)

_platform_toolchain = repository_rule(
    _platform_toolchain_impl,
    attrs = {
        "url": attr.string(mandatory = True),
        "integrity": attr.string(mandatory = True),
        "build_file": attr.label(allow_single_file = True, mandatory = True),
    },
)

_platform_toolchains = repository_rule(
    lambda ctx: _toolchain_build_file(ctx),
    attrs = {
        "build_file": attr.label(mandatory = True, allow_single_file = True),
    },
)
