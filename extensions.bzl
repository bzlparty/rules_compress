"Module Extensions"

load("//s2:repositories.bzl", "s2_platform_toolchains")

def _toolchains_extension_impl(_):
    s2_platform_toolchains(name = "s2")

toolchains = module_extension(
    _toolchains_extension_impl,
    tag_classes = {
        "s2": tag_class(attrs = {}),
    },
)
