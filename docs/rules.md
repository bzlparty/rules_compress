<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API

<a id="s2c"></a>

## s2c

<pre>
s2c(<a href="#s2c-name">name</a>, <a href="#s2c-cpu">cpu</a>, <a href="#s2c-index">index</a>, <a href="#s2c-mode">mode</a>, <a href="#s2c-out">out</a>, <a href="#s2c-snappy">snappy</a>, <a href="#s2c-src">src</a>)
</pre>


This rule runs `s2c` to compress an input file.

See https://github.com/klauspost/compress/tree/master/s2#s2c for details.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="s2c-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="s2c-cpu"></a>cpu |  Amount of threads   | Integer | optional | <code>4</code> |
| <a id="s2c-index"></a>index |  Add seek index   | Boolean | optional | <code>True</code> |
| <a id="s2c-mode"></a>mode |  Either 'faster' or 'slower'   | String | optional | <code>"slower"</code> |
| <a id="s2c-out"></a>out |  Name of the compressed file   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="s2c-snappy"></a>snappy |  Generate Snappy compatible output   | Boolean | optional | <code>False</code> |
| <a id="s2c-src"></a>src |  Source file to compress   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


<a id="zip"></a>

## zip

<pre>
zip(<a href="#zip-name">name</a>, <a href="#zip-compression_level">compression_level</a>, <a href="#zip-out">out</a>, <a href="#zip-srcs">srcs</a>)
</pre>


This rule runs `7zz` to compress an input file.

See https://7-zip.org/ for details.


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="zip-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="zip-compression_level"></a>compression_level |  Name of the compressed file   | Integer | optional | <code>1</code> |
| <a id="zip-out"></a>out |  Name of the compressed file   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="zip-srcs"></a>srcs |  Source file to compress   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |


<a id="S2FileInfo"></a>

## S2FileInfo

<pre>
S2FileInfo(<a href="#S2FileInfo-output">output</a>, <a href="#S2FileInfo-input">input</a>, <a href="#S2FileInfo-is_self_extractable">is_self_extractable</a>)
</pre>

S2 File Provider

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="S2FileInfo-output"></a>output |  Compressed file    |
| <a id="S2FileInfo-input"></a>input |  Input file    |
| <a id="S2FileInfo-is_self_extractable"></a>is_self_extractable |  Whether or not the output is self-extractable    |


<a id="gz_compress"></a>

## gz_compress

<pre>
gz_compress(<a href="#gz_compress-name">name</a>, <a href="#gz_compress-src">src</a>, <a href="#gz_compress-out">out</a>, <a href="#gz_compress-kwargs">kwargs</a>)
</pre>

Macro around zip rule to compress with gzip

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="gz_compress-name"></a>name |  Name of the target   |  none |
| <a id="gz_compress-src"></a>src |  Label of the input   |  none |
| <a id="gz_compress-out"></a>out |  Name of the output file   |  <code>None</code> |
| <a id="gz_compress-kwargs"></a>kwargs |  All other args of zip   |  none |


<a id="s2_compress"></a>

## s2_compress

<pre>
s2_compress(<a href="#s2_compress-name">name</a>, <a href="#s2_compress-out">out</a>, <a href="#s2_compress-kwargs">kwargs</a>)
</pre>

Macro around s2c rule

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="s2_compress-name"></a>name |  Name of the target   |  none |
| <a id="s2_compress-out"></a>out |  Name of the output file   |  <code>None</code> |
| <a id="s2_compress-kwargs"></a>kwargs |  All other args of [s2c](#s2c)   |  none |


