import { ConvertBlobToText, ConvertTextToBlob } from './BCBlob'

const text: string = ConvertBlobToText("0x02457d5b0580310900000804abe86e101b5840b78307fb0f4f1fa862f46c1a")
const blob: string = ConvertTextToBlob("Hello, World!") 

console.log(text)
console.log(blob)