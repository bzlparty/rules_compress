"Repository Utils"

def _toolchain_build_file(ctx, **kwargs):
    ctx.template("BUILD.bazel", ctx.attr.build_file, executable = False, **kwargs)

def _compress_toolchain_repo(implementation):
    def compress_toolchain_repo_impl(ctx):
        implementation(ctx)
        _toolchain_build_file(ctx)

    return compress_toolchain_repo_impl

compress_toolchain_repo = struct(
    implementor = _compress_toolchain_repo,
    attrs = {
        "platform": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
        "build_file": attr.label(allow_single_file = True, mandatory = True),
    },
)

combined_toolchains_repo = repository_rule(
    lambda ctx: _toolchain_build_file(ctx),
    attrs = {
        "build_file": attr.label(mandatory = True),
    },
)
