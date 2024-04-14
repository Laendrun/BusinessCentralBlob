# Business Central Blob - TypeScript

This repository contains a simple TypeScript module that contains two functions to convert text to Blob and Blob to text:

- `ConvertBlobToText`: Converts a Blob to a text.
- `ConvertTextToBlob`: Converts a text to a Blob.
- `ConvertBlobsToTexts`: Converts an array of Blobs to an array of texts.
- `ConvertTextsToBlobs`: Converts an array of texts to an array of Blobs.

## How to use

1. Run `npm install` to save the dependencies.
2. Run `npm run build` to transpile the TypeScript code to JavaScript.
3. Import the functions from the `BCBlob.ts` file in your script and use them.

```typescript
import { ConvertBlobToText, ConvertTextToBlob } from './BCBlob'

let text: string = "Hello, World!"
let blob: string = ConvertTextToBlob(text)
text = ConvertBlobToText(blob)

console.log(text)
```

> Note: You can pass the Blob starting with `0x` or without it.

## Example

You can find an example in the `src/example.ts` file.