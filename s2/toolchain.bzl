"S2 Toolchain"

S2Info = provider(
    doc = "S2 Toolchain Provider",
    fields = {
        "executable": "S2 Compress executable",
    },
)

def _s2_toolchain_impl(ctx):
    executable = ctx.file.executable
    default_info = DefaultInfo(
        files = depset([executable]),
        runfiles = ctx.runfiles(files = [executable]),
    )
    s2_info = S2Info(
        executable = executable,
    )
    toolchain_info = platform_common.ToolchainInfo(
        s2_info = s2_info,
        default = default_info,
    )

    return [default_info, toolchain_info]

s2_toolchain = rule(
    _s2_toolchain_impl,
    attrs = {
        "executable": attr.label(allow_single_file = True),
    },
)
