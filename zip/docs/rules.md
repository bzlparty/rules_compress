<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Zip Public API

<a id="zip"></a>

## zip

<pre>
zip(<a href="#zip-name">name</a>, <a href="#zip-compression_level">compression_level</a>, <a href="#zip-out">out</a>, <a href="#zip-srcs">srcs</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="zip-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="zip-compression_level"></a>compression_level |  Name of the compressed file   | Integer | optional | <code>1</code> |
| <a id="zip-out"></a>out |  Name of the compressed file   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="zip-srcs"></a>srcs |  Source file to compress   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |


<a id="gz_compress"></a>

## gz_compress

<pre>
gz_compress(<a href="#gz_compress-name">name</a>, <a href="#gz_compress-src">src</a>, <a href="#gz_compress-out">out</a>, <a href="#gz_compress-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="gz_compress-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="gz_compress-src"></a>src |  <p align="center"> - </p>   |  none |
| <a id="gz_compress-out"></a>out |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="gz_compress-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


