//This is a simple node program that takes a string of binary data
//that was copied from a hex editor and converts it into a string of
//data words that is compatible with the Ophis assembler. The
//starting address must be manually changed in the program along
//with ths string to convert.  The program takes no arguments.

let inString = "25 89 28 89 2B 89 31 89 34 89 2A 8A 37 89 3A 89 3D 89 40 89 43 89 49 89 4C 89 52 89 55 89 58 89 5B 89 5E 89 61 89 64 89 67 89 6A 89 6D 89 73 89 76 89 79 89 7C 89 7F 89 82 89 85 89 88 89 8B 89 8E 89 91 89 2E 89 94 89 97 89 9A 89 9D 89 A0 89 A3 89 A6 89 A9 89 AC 89 AF 89 B2 89 B5 89 BE 89 C1 89 CD 89 D0 89 C4 89 D3 89 EB 89 EE 89 F1 89 F4 89 F7 89 E8 89 D6 89 D9 89 DC 89 DF 89 E2 89 E5 89 E5 89 E5 89 E5 89 FA 89 FD 89 00 8A 30 8A 03 8A 06 8A 09 8A 0C 8A 0F 8A 12 8A 15 8A 18 8A 1B 8A 1E 8A 21 8A 24 8A 70 89 36 8A 39 8A 3C 8A 22 89 B8 89 BB 89 C7 89 CA 89 33 8A 27 8A 2D 8A 46 89 4F 89 1D 92 9F 91 A2 91 A5 91 A8 91 AB 91 AE 91 B1 91 B4 91 B7 91 BA 91 BD 91 C0 91 C3 91 C6 91 C9 91 CC 91 CF 91 D2 91 D5 91 D8 91 DB 91 DE 91 E1 91 E4 91 E7 91 EA 91 ED 91 F0 91 F3 91 F6 91 F9 91 FC 91 FF 91 02 92 05 92 08 92 0B 92 0E 92 11 92 17 92 1A 92 20 92 23 92 26 92 29 92 14 92";

let address = 0x8800;

let byteCount = 0;
let outString = "";

let inArray = inString.split(" ");

for(let i = 0; i < inArray.length; i += 2)
{
    if(i + 1 >= inArray.length)
    {
        console.log("\n Odd number of bytes detected.");
        console.log(outString);
        return;
    }

    if(!byteCount)
    {
        outString += "L" + address.toString(16).toUpperCase() + ":  .word ";
    }

    outString += "$" + inArray[i+1] + inArray[i];

    if(byteCount < 14)
    {
        outString += ", ";
        byteCount += 2;
    }
    else
    {
        outString += "\n";
        byteCount = 0;
    }

    address += 2;
}

console.log(outString);
