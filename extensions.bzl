"Module Extensions"

load("@bzlparty_tools//lib:toolchains.bzl", "register_platform_toolchains")
load("//s2:assets.bzl", S2_ASSETS = "ASSETS")
load("//zip:assets.bzl", ZIP_ASSETS = "ASSETS")

TOOLS = {
    "s2": struct(assets = S2_ASSETS, toolchain_type = "s2c_toolchain_type"),
    "zip": struct(assets = ZIP_ASSETS, toolchain_type = "7zz_toolchain_type"),
}

def _has_tag(module, tag):
    return hasattr(module.tags, tag) and len(getattr(module.tags, tag)) > 0

def _toolchains_extension_impl(ctx):
    for module in ctx.modules:
        for (name, config) in TOOLS.items():
            if _has_tag(module, name):
                toolchain_type = "@bzlparty_rules_compress//{}:{}".format(name, config.toolchain_type)
                register_platform_toolchains(name, config.assets, toolchain_type)

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
