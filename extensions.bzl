"Module Extensions"

load("@bzlparty_rules_compress//compress:s2_assets.bzl", S2_ASSETS = "ASSETS")
load("@bzlparty_rules_compress//compress:zip_assets.bzl", ZIP_ASSETS = "ASSETS")
load("@bzlparty_tools//lib:defs.bzl", "register_platform_toolchains")
load(
    "@bzlparty_tools//vendor/aspect_bazel_lib:extension_utils.bzl",
    "extension_utils",
)

def _toolchains_extension_impl(ctx):
    extension_utils.toolchain_repos_bfs(
        mctx = ctx,
        get_version_fn = lambda _: "0.0.0",
        get_tag_fn = lambda tags: tags.s2,
        toolchain_name = "s2",
        toolchain_repos_fn = lambda name, version: register_platform_toolchains(name = name, assets = S2_ASSETS, toolchain_type = "@bzlparty_rules_compress//compress:s2_toolchain_type"),
    )

    extension_utils.toolchain_repos_bfs(
        mctx = ctx,
        get_version_fn = lambda _: "0.0.0",
        get_tag_fn = lambda tags: tags.zip,
        toolchain_name = "zip",
        toolchain_repos_fn = lambda name, version: register_platform_toolchains(name = name, assets = ZIP_ASSETS, toolchain_type = "@bzlparty_rules_compress//compress:zip_toolchain_type"),
    )

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
