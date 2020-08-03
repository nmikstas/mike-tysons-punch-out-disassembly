# mike-tysons-punch-out-disassembly
Reverse engineering effort of the NES game Mike Tyson's Punch-Out.

# Folder Structure
**documentation** - various documentation for the disassembly. Contains the completion map which is a visual representation of the progress on the disassembly.  
**helper_programs** - Small helper programs used to format data tables, etc. The programs are written with Javascript and can be run with Node.  
**ophis** - Ophis binary used to assemble the source code.  
**original_files** - Binary images of the memory banks from the original game.  
**output_files** - Assembled binaries are placed here after the build script is run.  They should be identical to the original binary files.  
**source_files** - Where the actual disassembled game is located.  

# Build Script
The build_script file can be run from Git bash to assemble the source files and do checksums on the output files and original files.  This file can be modified to produce a working ROM.  Also, if one were inclined to find the original dragon warrior NES ROM, they could include it in the root directory and run a checksum on the assembled ROM file...  
