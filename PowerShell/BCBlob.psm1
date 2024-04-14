function ConvertBlobToText {
	param (
		[string]$hexString
	)

	$blob_magic = [byte[]]@(2, 69, 125, 91)

	if ($hexString.Substring(0, 2) -eq "0x") {
		$hexString = $hexString.Substring(2)
	}

	# Convert hexadecimal string to bytes
	$inBytes = [byte[]]@(for ($i = 0; $i -lt $hexString.Length; $i += 2) { [convert]::ToByte($hexString.Substring($i, 2), 16) })

	# Check if input bytes are null or less than 4 bytes
	if (-not $inBytes -or $inBytes.Length -lt 4) {
		return $null
	}

	# Check if first four bytes match the magic header
	$firstFourBytes = $inBytes[0..3]
	if (-not (($firstFourBytes -join ',') -eq ($blob_magic -join ','))) {
		return $null
	}

	try {
		# Decompress the input bytes using System.IO.Compression.DeflateStream
		$inStream = New-Object System.IO.MemoryStream($inBytes, 4, ($inBytes.Length - 4))
		$deflateStream = New-Object System.IO.Compression.DeflateStream($inStream, [System.IO.Compression.CompressionMode]::Decompress)
		$decompressedBytes = New-Object byte[] ($inBytes.Length * 3)
		$null = $deflateStream.Read($decompressedBytes, 0, $decompressedBytes.Length)
		$inStream.Close()
		$deflateStream.Close()

		$lastNonZeroIndex = $decompressedBytes.Length - 1
		while ($lastNonZeroIndex -ge 0 -and $decompressedBytes[$lastNonZeroIndex] -eq 0) { $lastNonZeroIndex-- }
		$decompressedBytes = $decompressedBytes[0..$lastNonZeroIndex]

		try {
			$text = [System.Text.Encoding]::UTF8.GetString($decompressedBytes)
			return $text
		} catch {
			Write-Host "Error converting bytes to string: $_"
			return $null
		}
	} catch {
		Write-Host "Error occurred during decompression: $_"
		return $null
	}
}

function ConvertTextToBlob {
	param (
		[string]$inputString
	)

	$blob_magic = [byte[]]@(2, 69, 125, 91)
	try {
		# Convert the string to bytes
		$bytes = [System.Text.Encoding]::UTF8.GetBytes($inputString)

		# Compress the bytes using Deflate algorithm
		$compressedStream = New-Object System.IO.MemoryStream
		$deflateStream = New-Object System.IO.Compression.DeflateStream($compressedStream, [System.IO.Compression.CompressionMode]::Compress)
		$deflateStream.Write($bytes, 0, $bytes.Length)
		$deflateStream.Close()

		$compressedBytes = $compressedStream.ToArray()

		$combinedBytes = $blob_magic + $compressedBytes

		# Convert the compressed bytes to an hexadecimal string
		$hexString = [System.BitConverter]::ToString($combinedBytes) -replace '-'
		
		return $hexString
	} catch {
		Write-Host "Error occured during compression: $_"
		return $null
	}
}

function ConvertBlobsToTexts {
	param (
		[string[]]$hexStrings
	)

	$texts = @()
	$hexStrings | ForEach-Object {
		$texts += ConvertBlobToText($_)
	}

	return $texts
}

function ConvertTextsToBlobs {
	param (
		[string[]]$texts
	)

	$hexStrings = @()
	$texts | ForEach-Object {
		$hexStrings += ConvertTextToBlob($_)
	}

	return $hexStrings
}
