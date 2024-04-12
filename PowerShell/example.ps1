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