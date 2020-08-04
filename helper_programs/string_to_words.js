//This is a simple node program that takes a string of binary data
//that was copied from a hex editor and converts it into a string of
//data words that is compatible with the Ophis assembler. The
//starting address must be manually changed in the program along
//with ths string to convert.  The program takes no arguments.

let inString = "00 00";

let address = 0x8000;

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
