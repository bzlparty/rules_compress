"Toolchain Utils"

CompressToolchainInfo = provider(
    doc = "Compressor Toolchain Provider",
    fields = {
        "executable": "Compressor executable",
    },
)

def _compress_toolchain_impl(ctx):
    executable = ctx.file.executable
    default_info = DefaultInfo(
        files = depset([executable]),
        runfiles = ctx.runfiles(files = [executable]),
    )
    compress_info = CompressToolchainInfo(
        executable = executable,
    )
    toolchain_info = platform_common.ToolchainInfo(
        compress_info = compress_info,
        default = default_info,
    )

    return [default_info, toolchain_info]

compress_toolchain = rule(
    _compress_toolchain_impl,
    attrs = {
        "executable": attr.label(allow_single_file = True),
    },
)
