//This is a simple node program that takes a binary file and converts it into
//hexadecimal bytes compatible with the Ophis assembler. It takes a single
//argument of the file to convert. It will create an .asm file in the present
//working directory with the same name as the input file.  It was used to
//create assemblable versions of the CHR ROM banks. 

let fs = require("fs");
let inFile = process.argv[2];

let processBinDat = (data) =>
{
    let byteCounter = 0;
    let outputString = "\n.org $0000\n\n";

    for(let i = 0; i < data.length; i++)
    {
        //Get data byte from file.
        let hexString = data[i].toString(16).toUpperCase();

        //If the data byte is lexx than $10, prepend a 0.
        if(hexString.length === 1)
        {
            hexString = "0" + hexString;
        }

        //Prepend a $.
        hexString = "$" + hexString;

        //A new line with additional data is created every 16 bytes.
        if(byteCounter === 0)
        {
            outputString += ".byte ";
        }

        outputString += hexString;
        byteCounter++;

        //Start a new line every 16 bytes.
        if(byteCounter >= 16)
        {
            byteCounter = 0;
            outputString += "\n";
        }
        else
        {
            //If not the 16th byte, just append to end of current line.
            outputString += ", ";
        }
    }

    //Print the final results to the screen.
    console.log(outputString);

    //Separate out all the path information to the input file.
    let outFile;
    let filePath = inFile.split(".");

    if(filePath.length < 2)
    {
        outFile = filePath[0];
    }
    else
    {
        outFile = filePath[filePath.length - 2];
    }

    filePath = outFile.split("/");
    outFile = filePath[filePath.length - 1] + ".asm";

    //Print the output filename to the console.
    console.log(outFile);

    //Write the string to a file with the same name but with an .asm extension.
    fs.writeFile(outFile, outputString, (err) =>
    {
        if(err) console.log(err);
    });
}

fs.readFile(inFile, null, (error, data) =>
{
    //Report any errors.
    if(error) return console.log(error);
    
    //Process binary data into assembly compatible strings.
    processBinDat(data);  
});