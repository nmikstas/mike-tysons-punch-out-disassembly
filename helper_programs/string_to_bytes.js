//This is a simple node program that takes a string of binary data
//that was copied from a hex editor and converts it into a string of
//data bytes that is compatible with the Ophis assembler. The
//starting address must be manually changed in the program along
//with ths string to convert.  The program takes no arguments.

let inString = "00 00";

let address = 0x808C;

let byteCount = 0;
let outString = "";

let inArray = inString.split(" ");

for(let i = 0; i < inArray.length; i++)
{
    if(!byteCount)
    {
        outString += "L" + address.toString(16).toUpperCase() + ":  .byte ";
    }

    outString += "$" + inArray[i];

    if(byteCount < 15)
    {
        outString += ", ";
        byteCount++;
    }
    else
    {
        outString += "\n";
        byteCount = 0;
    }

    address++;
}

console.log(outString);