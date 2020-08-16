//This is a simple node program that takes a string of binary data
//that was copied from a hex editor and converts it into a string of
//data words that is compatible with the Ophis assembler. The
//starting address must be manually changed in the program along
//with ths string to convert.  The program takes no arguments.

let inString = "5C 82 69 82 76 82 83 82 90 82 9D 82 AA 82 B3 82 BE 82 CB 82 D6 82 E1 82 EC 82 F7 82 02 83 0F 83 1A 83 27 83 32 83 3F 83 4A 83 55 83 60 83 6B 83 76 83 81 83 8C 83 97 83 A2 83 AD 83 BA 83 C5 83 D2 83 DB 83 E4 83 ED 83 01 84 D9 81 E0 81 E7 81 EE 81 F5 81 FA 81 FA 83";

let address = 0x8204;

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
