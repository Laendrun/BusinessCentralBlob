# Business Central Blob - Python

This repository contains a simple module that contains two functions to convert text to Blob and Blob to text:

- `ConvertBlobToText`: Converts a Blon to a text.
- `ConvertTextToBlob`: Converts a text to a Blob.
- `ConvertBlobsToTexts`: Converts a list of Blobs to a list of texts.
- `ConvertTextsToBlobs`: Converts a list of texts to a list of Blobs.

## How to use

Import the functions from the `BCBlob.py` file in your script and use them.

```python
from BCBlob import ConvertBlobToText, ConvertTextToBlob

text = "Hello, World!"
blob = ConvertTextToBlob(text)
text = ConvertBlobToText(blob)

print(text)
```

> Note: You can pass the Blob starting with `0x` or without it.

## Example

You can find an example in the `example.py` file.

### Use the example
```
$> python example.py
$> Hello, World!
```
