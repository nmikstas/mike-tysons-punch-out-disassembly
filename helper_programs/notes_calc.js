//This is a simple node program that takes a string of binary data
//and calculates the frequency it plays on the NES hardware.

let notesDataArray = 
[
    0x06AE, 0x064E, 0x05F3, 0x059E, 0x054D, 0x0502, 0x04B9, 0x0475,
    0x0435, 0x03F8, 0x03BF, 0x0389, 0x0357, 0x0327, 0x02F9, 0x02CF,
    0x02A6, 0x0280, 0x025C, 0x023A, 0x021A, 0x01FC, 0x01DF, 0x01C4,
    0x01AB, 0x0193, 0x017C, 0x0167, 0x0152, 0x013F, 0x012D, 0x011C,
    0x010C, 0x00FD, 0x00EE, 0x00E1, 0x00D4, 0x00C8, 0x00BD, 0x00B2,
    0x00A8, 0x009F, 0x0096, 0x008D, 0x0085, 0x007E, 0x0076, 0x0070,
    0x006A, 0x0064, 0x005F, 0x0059, 0x0054, 0x0050, 0x004B, 0x0047,
    0x0043, 0x003F, 0x003B, 0x0038, 0x0035, 0x0032
];

 const CPU = 1789773;
 let index = 4;

for(let i = 0; i < notesDataArray.length; i++)
{
    //f = CPU / (16 * (t + 1))
    let freq = CPU / (16 * (notesDataArray[i] + 1));

    console.log("Index #$" + index.toString(16).toUpperCase() + " - " + freq.toFixed(2) + "Hz");
    index += 2;
}