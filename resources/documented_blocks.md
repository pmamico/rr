# Documented Blocks

This is a sample for testing `rr`, the readme runner.  

For example, you can run the following code block:

build
```sh
echo "build"
```

by running `rr 1`, because it's the first code block in the file 
or with `rr build`, because it has the "build" label.  

The name is normalized, eg.

## Second Block
```sh
echo "Second Block"
```

can be run with `rr 2` or `rr second block`.  

But this is not a runnable block:
```json
{ "foo": "bar" }
```

`rr` respects the language of the code block, and runs only `sh` and `bash` blocks.

```bash
echo "Block without a label"
```