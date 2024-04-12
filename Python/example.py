from BCBlob import ConvertBlobToText, ConvertTextToBlob

text = "Hello, World!"
blob = ConvertTextToBlob(text)
text = ConvertBlobToText(blob)
print(text)