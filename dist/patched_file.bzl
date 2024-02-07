"Patched File"

def patched_file(name, src, patch, out = None):
    "Apply a patch to a given source file"

    native.genrule(
        name = name,
        outs = [out or "%s.patched" % Label(src).name],
        cmd = "patch --follow-symlinks -o $(OUTS) -i $(location {patch}) $(rootpath {src})".format(src = src, patch = patch),
        srcs = [src, patch],
    )
