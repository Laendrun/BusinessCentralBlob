# Business Central Blob - PowerShell

This repository contains a simple module that contains two functions to convert text to Blob and Blob to text:

- `ConvertTextToBlob`: Converts a text to a Blob.
- `ConvertBlobToText`: Converts a Blob to a text.

## How to use

### Module way

1. Clone the repository.
2. Import the module in your script.
3. Use the functions.

```powershell
# Import the module in your script
Import-Module .\BusinessCentralBlob.psm1

# Use the functions
$text = "Hello, World!"
$blob = ConvertTextToBlob $text
$text = ConvertBlobToText $blob

Write-Output $text
```

### Script way

You can also use the functions directly in your script without importing the module.

Simply copy the functions in your script from the `BCBlob.psm1` and then use it.

> Note: The `ConvertBlobToText` function uses the `blobMagicOk` function to check if the Blob has the magic header. Don't forget to copy this function in your script as well.

```powershell
function ConvertTextToBlob {
	# Function code
}

function ConvertBlobToText {
	# Function code
}

function blobMagicOk {
	# Function code
}

$text = "Hello, World!"
$blob = ConvertTextToBlob $text
$text = ConvertBlobToText $blob

Write-Output $text
```

## Example

You can find an example in the `example.ps1` file.

### Use the example

To run the example script, you can use the following command:

```powershell
PS> .\example.ps1 -Text "Hello, World!"
PS> 02457D5BF348CDC9C9D75108CF2FCA49510400
PS>
PS> .\example.ps1 -Blob "02457D5BF348CDC9C9D75108CF2FCA49510400"
PS> Hello, World!
PS>
PS> .\example.ps1 -Text "Hello, World!" -Blob "02457D5BF348CDC9C9D75108CF2FCA49510400"
PS> 02457D5BF348CDC9C9D75108CF2FCA49510400
PS> Hello, World!
```

> Note: You can pass the Blob starting with `0x` or not.
