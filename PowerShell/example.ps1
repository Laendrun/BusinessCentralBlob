param (
	[string]$text,
	[string]$blob
)
Import-Module -Name ".\BCBlob.psm1" -Force

if (-not [string]::IsNullOrEmpty($text)) {
	Write-Host (ConvertTextToBlob($text))
} 
if (-not [string]::IsNullOrEmpty($blob)) {
	Write-Host (ConvertBlobToText($blob))
}

$texts = "Hello", "World", "!"
$blobs = ConvertTextsToBlobs($texts)

Write-Host $blobs

$blobs = "02457D5BF348CDC9C90700", "02457D5B0BCF2FCA490100", "02457D5B530400"
$texts = ConvertBlobsToTexts($blobs)

Write-Host $texts