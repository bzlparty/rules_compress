"Module Extensions"

load("//s2:toolchain.bzl", "s2_toolchain_repo")

def _toolchains_extension_impl(_):
    s2_toolchain_repo(name = "s2_toolchain")

toolchains = module_extension(
    _toolchains_extension_impl,
    tag_classes = {
        "s2": tag_class(attrs = {}),
    },
)
