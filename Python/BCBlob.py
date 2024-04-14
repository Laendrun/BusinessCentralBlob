import zlib
import binascii

def ConvertBlobToText(blob: str) -> str:
	blob_magic = bytes([2, 69, 125, 91])

	if (blob[:2] == "0x"):
		blob = blob[2:]

	# Convert hexadecimal string to bytes
	in_bytes = binascii.unhexlify(blob)
	# Check if input bytes are null or less than 4 bytes
	if not in_bytes or len(in_bytes) < 4:
		return None
	# Check if the first four bytes match the magic header
	first_four_bytes = in_bytes[:4]
	if not first_four_bytes == blob_magic:
		return None
	try:
		# Decompress the input bytes using zlib with raw Deflate data
		decompressed_bytes = zlib.decompress(in_bytes[4:], -zlib.MAX_WBITS)
		return decompressed_bytes.decode('utf-8')
	except Exception as e:
		print("Error occurred during decompression:", e)
	try:
		return decompressed_bytes.decode('utf-8')
	except UnicodeDecodeError:
		print("Failed to decode decompressed bytes as UTF-8")
		return None


def ConvertTextToBlob(text: str) -> str:
	blob_magic = bytes([2, 69, 125, 91])
	input_bytes = text.encode('utf-8')
	try:
		# Compress the input text using zlib with raw Deflate data
		compressed_bytes = zlib.compress(input_bytes, wbits=-zlib.MAX_WBITS)
		# Combine the magic header and compressed bytes
		combined_bytes = blob_magic + compressed_bytes
		# Convert the combined bytes to a hexadecimal string
		hex_string = binascii.hexlify(combined_bytes).decode('utf-8')
		return hex_string
	except Exception as e:
		print("Error occurred during compression:", e)
		return None

def ConvertBlobsToText(blobs: list) -> list:
	return [ConvertBlobToText(blob) for blob in blobs]

def ConvertTextsToBlob(texts: list) -> list:
	return [ConvertTextToBlob(text) for text in texts]