"S2 Compression rule"

S2FileInfo = provider(
    doc = "S2 File Provider",
    fields = {
        "output": "Compressed file",
        "input": "Input file",
        "is_self_extractable": "Whether or not the output is self-extractable",
    },
)

def _s2_compress_impl(ctx):
    toolchain = ctx.toolchains["@bzlparty_rules_compress//s2:s2c_toolchain_type"].s2_info
    args = ctx.actions.args()
    args.add("-o", ctx.outputs.out)
    args.add("-%s" % ctx.attr.mode)
    args.add("-q")
    args.add(ctx.file.src)

    ctx.actions.run(
        inputs = [ctx.file.src],
        outputs = [ctx.outputs.out],
        executable = toolchain.executable,
        mnemonic = "S2Compress",
        progress_message = "Compress: %{input} > %{output}",
        arguments = [args],
    )

    runfiles = ctx.runfiles(files = [ctx.file.src])

    return [
        DefaultInfo(
            files = depset([ctx.outputs.out]),
            runfiles = runfiles,
        ),
        S2FileInfo(
            output = depset([ctx.outputs.out]),
            input = depset([ctx.file.src]),
            is_self_extractable = False,
        ),
    ]

s2_compress = rule(
    _s2_compress_impl,
    attrs = {
        "mode": attr.string(
            doc = "Either 'faster' or 'slower'",
            default = "slower",
            values = ["faster", "slower"],
        ),
        "snappy": attr.bool(
            doc = "Generate Snappy compatible output",
            default = False,
        ),
        "out": attr.output(
            doc = "Name of the compressed file",
            mandatory = True,
        ),
        "src": attr.label(
            doc = "Source file to compress",
            allow_single_file = True,
            mandatory = True,
        ),
    },
    toolchains = ["@bzlparty_rules_compress//s2:s2c_toolchain_type"],
)
