from BCBlob import ConvertBlobToText, ConvertTextToBlob

text = "Hello, World!"
blob = ConvertTextToBlob(text)
text = ConvertBlobToText("0x02457D5BF348CDC9C9D75108CF2FCA49510400")
print(text)