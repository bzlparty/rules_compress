"S2 Compress Test Suite"

load("@bazel_skylib//lib:unittest.bzl", "analysistest", "asserts")
load("//compress:defs.bzl", "s2_compress")

def _get_single_output_from_actions(env):
    actions = analysistest.target_actions(env)
    return actions[0].outputs.to_list()[0]

def _s2_compress_output_test_impl(ctx):
    env = analysistest.begin(ctx)

    output = _get_single_output_from_actions(env)
    asserts.equals(env, "test_file.s2", output.basename)

    return analysistest.end(env)

s2_compress_output_test = analysistest.make(_s2_compress_output_test_impl, expect_failure = True)

def _s2_compress_auto_output_test_impl(ctx):
    env = analysistest.begin(ctx)

    output = _get_single_output_from_actions(env)
    asserts.equals(env, "test_file_compress_2.s2", output.basename)

    return analysistest.end(env)

s2_compress_auto_output_test = analysistest.make(_s2_compress_auto_output_test_impl, expect_failure = True)

def _s2_compress_snappy_output_test_impl(ctx):
    env = analysistest.begin(ctx)

    output = _get_single_output_from_actions(env)
    asserts.equals(env, "test_file_compress_snappy.sz", output.basename)

    return analysistest.end(env)

s2_compress_snappy_output_test = analysistest.make(_s2_compress_snappy_output_test_impl, expect_failure = True)

# buildifier: disable=function-docstring
def s2_compress_test_suite(name):
    s2_compress_output_test(
        name = "s2_compress_output_test",
        target_under_test = ":test_file_compress",
    )

    s2_compress_auto_output_test(
        name = "s2_compress_auto_output_test",
        target_under_test = ":test_file_compress_2",
    )

    s2_compress_snappy_output_test(
        name = "s2_compress_snappy_output_test",
        target_under_test = ":test_file_compress_snappy",
    )

    native.genrule(
        name = "test_file_gen",
        outs = ["test_file"],
        cmd = "head -c 1MB </dev/urandom >$(OUTS)",
    )

    s2_compress(
        name = "test_file_compress",
        src = ":test_file",
        out = "test_file.s2",
    )

    s2_compress(
        name = "test_file_compress_2",
        src = ":test_file",
    )

    s2_compress(
        name = "test_file_compress_snappy",
        src = ":test_file",
        snappy = True,
    )

    native.test_suite(
        name = name,
        tests = [
            ":s2_compress_auto_output_test",
            ":s2_compress_output_test",
            ":s2_compress_snappy_output_test",
        ],
    )
