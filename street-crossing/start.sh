#!/bin/bash

# Exit if any command fails
set -e

# Check if a filename is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <filename.asm>"
    exit 1
fi

# Check if nasm is installed
if ! command -v nasm &> /dev/null; then
    echo "nasm not found. Attempting to install..."
    sudo apt-get update
    sudo apt-get install nasm
fi

# Extract the file extension
filename="$1"
extension="${filename##*.}"

# Rest of your script remains unchanged
# ...

# Check the file extension
if [ "$extension" == "asm" ]; then
    # Compile with NASM
    nasm -f elf -o "${filename%.asm}.o" "$filename"
    
    # Link with ld
    ld -m elf_i386 -s -o "${filename%.asm}" "${filename%.asm}.o"

    # Run the program
    ./"${filename%.asm}"

    # Remove the executable
    rm "${filename%.asm}" "${filename%.asm}.o"

elif [ "$extension" == "c" ]; then
    # Compile with GCC
    gcc -o "${filename%.c}" "$filename"
    
    # Run the program
    ./"${filename%.c}"

    # Remove the executable
    rm "${filename%.c}"

else
    echo "Unsupported file extension: $extension"
fi
