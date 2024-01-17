"Utils"

def _is_windows(platform):
    return platform.startswith("windows")

def executable_target(name, platform):
    return name + (".exe" if _is_windows(platform) else "")

def zip_toolchain_build_file(ctx, build_file, **kwargs):
    "Create a build file to put in a platform toolchain"
    ctx.template("BUILD.bazel", build_file, **kwargs)
