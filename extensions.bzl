"Module Extensions"

load("//s2:repositories.bzl", "s2_platform_toolchains")
load("//zip:repositories.bzl", "zip_platform_toolchains")

def _toolchains_extension_impl(ctx):
    for m in ctx.modules:
        for _ in m.tags.s2:
            s2_platform_toolchains(name = "s2")
        for _ in m.tags.zip:
            zip_platform_toolchains(name = "zip")

toolchains = module_extension(
    _toolchains_extension_impl,
    tag_classes = {
        "s2": tag_class(attrs = {}),
        "zip": tag_class(attrs = {}),
    },
)
