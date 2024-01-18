"Toolchain Utils"

def toolchain_build_file(ctx, build_file = None, **kwargs):
    if not build_file and ctx.attr._build_file:
        build_file = ctx.attr._build_file
    ctx.template("BUILD.bazel", build_file, executable = False, **kwargs)
