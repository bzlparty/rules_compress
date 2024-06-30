"Module Extensions"

load("//s2:assets.bzl", S2_ASSETS = "ASSETS")
load("//utils:repositories.bzl", "compress_toolchains")
load("//zip:assets.bzl", ZIP_ASSETS = "ASSETS")

TOOLS = {
    "s2": S2_ASSETS,
    "zip": ZIP_ASSETS,
}

def _has_tag(module, tag):
    return hasattr(module.tags, tag) and len(getattr(module.tags, tag)) > 0

def _toolchains_extension_impl(ctx):
    for module in ctx.modules:
        for (name, assets) in TOOLS.items():
            if _has_tag(module, name):
                compress_toolchains(name, assets)

toolchains = module_extension(
    _toolchains_extension_impl,
    tag_classes = {
        "s2": tag_class(attrs = {
            "name": attr.string(default = "s2"),
        }),
        "zip": tag_class(attrs = {
            "name": attr.string(default = "zip"),
        }),
    },
)
