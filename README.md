# BusinessCentralBlob

## What is a "Blob"?

A "Blob" is a Binary Large Object, a collection of binary data stored as a single entity in a database management system. Blobs are typically images, audio or other multimedia objects, though sometimes binary executable code is stored as a blob.

In Business Central, a "Blob" is a data type that is used to store images or large texts.
Most of the time, you will use Blobs to store texts because there's a special data type for images called "MediaSet".

You can find more information about Blobs in the [official documentation](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/methods-auto/blob/blob-data-type).

## How to use Blobs in Business Central?

In Business Central AL, you can use Blobs in the same way you use any other data type. You can declare a Blob variable, assign a value to it, and read its value.
There are a few functions that you can use to work with Blobs:
- `CreateInStream(InStream [,TextEncoding])` : Creates an InStream object that you can use to read the Blob.
- `CreateOutStream(OutStream [,TextEncoding])` : Creates an OutStream object that you can use to write to the Blob.
- `Export(Text)`: Exports the Blob to a file.
- `Import(Text)`: Imports the Blob from a file.
- `Length()`: Returns the length of the Blob in bytes.
- `HasValue()`: Returns true if the Blob has a value.

## How are blob stored in the database?

A field of type BLOB in Business Central is stored in a database column of type image.

Blobs are stored as an hexadecimal reprensentation (there's more than that) of the binary data. For example, the text "Hello, World!" would be stored as `0x02457D5BF348CDC9C9D75108CF2FCA49510400`.

## Why this repository?

For a project, I needed to retrieve a text stored as Blob from the Business Central database. 
I had to find a way to "translate" the hexadecimal representation of the Blob to a readable text and vice-versa.

I found multiple ways to do it, but none of them did the complete thing, or not in a language I could use (PowerShell).
I decided to create this repository to share my solution and help others who might need it, and I don't want to limit myself to a single language, so I will provide solutions in multiple languages.

## How to use this repository?

This repository contains multiple subdirectories, each one containing a solution in a different language as well as an example on how to use it.

The current languages available are:
- [PowerShell](https://github.com/Laendrun/BusinessCentralBlob/tree/main/PowerShell)
- [Python](https://github.com/Laendrun/BusinessCentralBlob/tree/main/Python)
- [TypeScript](https://github.com/Laendrun/BusinessCentralBlob/tree/main/TypeScript)

To use the solution in a specific language, you can follow the instructions in the README.md file of the corresponding subdirectory.

## How does Business Central converts text to Blob?

Business Central does not simply saved the text as raw bytes in the SQL database (that would be too easy right ?).

The text is first compressed using the Deflate algorithm, then it is stored a hexadecimal representation of the compressed data with a _magic_ prefix that tells Business Central it is a text.

This is the magic header hexadecimal representation: `0x02457D5B`.
It is stored as `blob_magic` in the different solutions.

### General Text to Blob conversion

1. Compress the text using the Deflate algorithm.
2. Prepend the magic header to the compressed data.
3. Convert the data to hexadecimal representation.

### General Blob to Text conversion

1. Convert the hexadecimal representation to binary data.
2. Remove the magic header.
3. Decompress the data using the Deflate algorithm.
4. Get the UTF-8 representation of the decompressed bytes data.

## Contributing

If you want to add a solution in a new language, feel free to create a pull request with your solution. Make sure to add an example on how to use it in the README.md file of the subdirectory.

If you find a mistake in one of the solutions, please open an issue so I can fix it.

## License

This repository is licensed under the LGPL-3.0 License. You can find more information in the [LICENSE](LICENSE) file.