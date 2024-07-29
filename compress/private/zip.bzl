"# 7-Zip Compression"

ZipFileInfo = provider(
    doc = "Zip File Provider",
    fields = {
        "output": "Compressed file",
        "inputs": "Input files",
    },
)

def _zip_impl(ctx):
    toolchain = ctx.toolchains["@bzlparty_rules_compress//compress:zip_toolchain_type"].binary_info

    if ctx.outputs.out.basename.endswith(".gz") and len(ctx.files.srcs) > 1:
        fail("gz can only compress a single file! %s files given" % len(ctx.files.srcs))

    args = ctx.actions.args()
    args.add("a")
    args.add("-bd")
    args.add("-bb0")
    args.add("-bso0")
    args.add("-mx%s" % ctx.attr.compression_level)
    args.add(ctx.outputs.out)
    args.add_joined(ctx.files.srcs, join_with = " ")

    ctx.actions.run(
        inputs = ctx.files.srcs,
        outputs = [ctx.outputs.out],
        executable = toolchain.binary,
        mnemonic = "ZipCompress",
        progress_message = "Compress: %{input} > %{output}",
        arguments = [args],
    )

    runfiles = ctx.runfiles(files = ctx.files.srcs)

    return [
        DefaultInfo(
            files = depset([ctx.outputs.out]),
            runfiles = runfiles,
        ),
        ZipFileInfo(
            output = depset([ctx.outputs.out]),
            inputs = depset(ctx.files.srcs),
        ),
    ]

zip = rule(
    _zip_impl,
    attrs = {
        "compression_level": attr.int(
            doc = "Name of the compressed file",
            default = 1,
            values = [1, 2, 3, 4, 5, 6, 7, 8, 9],
        ),
        "out": attr.output(
            doc = "Name of the compressed file",
            mandatory = True,
        ),
        "srcs": attr.label_list(
            allow_files = True,
            doc = "Source file to compress",
            mandatory = True,
        ),
    },
    doc = """
This rule runs `7zz` to compress an input file.

See https://7-zip.org/ for details.
""",
    toolchains = ["@bzlparty_rules_compress//compress:zip_toolchain_type"],
)
