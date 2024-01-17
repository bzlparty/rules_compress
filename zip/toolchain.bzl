"7Zip Toolchain"

ZipInfo = provider(
    doc = "7Zip Toolchain Provider",
    fields = {
        "executable": "zip Compress executable",
    },
)

def _zip_toolchain_impl(ctx):
    executable = ctx.file.executable
    default_info = DefaultInfo(
        files = depset([executable]),
        runfiles = ctx.runfiles(files = [executable]),
    )
    zip_info = ZipInfo(
        executable = executable,
    )
    toolchain_info = platform_common.ToolchainInfo(
        zip_info = zip_info,
        default = default_info,
    )

    return [default_info, toolchain_info]

zip_toolchain = rule(
    _zip_toolchain_impl,
    attrs = {
        "executable": attr.label(allow_single_file = True),
    },
)
