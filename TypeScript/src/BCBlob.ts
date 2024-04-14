import { RawInflate, RawDeflate } from "zlibt2/raw"

export const ConvertBlobToText = (blob: string): string|undefined => {
	const blob_magic: Uint8Array = new Uint8Array([2, 69, 125, 91])

	if (blob.slice(0,2) === "0x")
		blob = blob.slice(2,blob.length)

	let in_bytes: Uint8Array = new Uint8Array(blob.length)
	for (let c = 0, i = 0; c < blob.length; c += 2, i++)
		in_bytes[i] = parseInt(blob.substring(c, c + 2), 16)

	if (!in_bytes || in_bytes.length < 4) {
		return undefined;
	}

	let firstFourBytes: Uint8Array = new Uint8Array(in_bytes.slice(0,4))
	if (firstFourBytes.toString() !== blob_magic.toString()) {
		return undefined
	}

	try {
		let decompressed_bytes: Uint8Array = new RawInflate(in_bytes.slice(4)).decompress() as Uint8Array
		let text = new TextDecoder("utf-8").decode(decompressed_bytes)
		return text
	} catch (e) {
		console.error(`Error occuring during decompression: `,e)
		return undefined
	}
}

export const ConvertTextToBlob = (text: string): string|undefined => {
	const blob_magic: Uint8Array = new Uint8Array([2, 69, 125, 91])

	let text_bytes: Uint8Array = new TextEncoder().encode(text)
	let compressed_bytes: Uint8Array = new RawDeflate(text_bytes).compress() as Uint8Array
	let blob_bytes: Uint8Array = new Uint8Array(blob_magic.length + compressed_bytes.length)
	blob_bytes.set(blob_magic)
	blob_bytes.set(compressed_bytes, blob_magic.length)

	let blob: string = "0x"
	for (let i = 0; i < blob_bytes.length; i++)
		blob += blob_bytes[i].toString(16).padStart(2, "0")
	return blob
}

export const ConvertBlobsToTexts = (blobs: string[]): string[] => {
	let texts: string[] = []
	for (let i = 0; i < blobs.length; i++) {
		let text = ConvertBlobToText(blobs[i])
		if (text)
			texts.push(text)
	}
	return texts
}

export const ConvertTextsToBlobs = (texts: string[]): string[] => {
	let blobs: string[] = []
	for (let i = 0; i < texts.length; i++) {
		let blob = ConvertTextToBlob(texts[i])
		if (blob)
			blobs.push(blob)
	}
	return blobs
}
