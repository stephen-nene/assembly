# RISC-V Assembly code

# Function to sum an integer array
# Arguments: a0 = starting address of array, a1 = size of array
# Return: a0 = sum of the array (using integer register)
sum_int_array:
    # Save registers to stack
    addi sp, sp, -4    # Adjust stack pointer
    sw ra, 0(sp)       # Save return address

    # Initialize sum to 0
    li a0, 0            # Initialize sum to 0

    # Loop through the array
    la t0, array        # Load starting address of array
    li t1, 0            # Initialize loop counter to 0
loop:
    lw t2, 0(t0)       # Load array element
    addi t0, t0, 4     # Move to next element
    add a0, a0, t2     # Add array element to sum (using integer addition)
    addi t1, t1, 1     # Increment loop counter
    blt t1, a1, loop   # Continue loop until counter reaches array size

    # Restore registers from stack
    lw ra, 0(sp)      # Restore return address
    addi sp, sp, 4    # Restore stack pointer

    ret               # Return from function

# Main program
    .text
    .globl main       # Entry point of the program

main:
    # Initialize array and length
    la a0, array      # Load starting address of array
    lw a1, len        # Load size of array

    # Call sum_int_array function
    call sum_int_array

    # Result is in a0
    # Do whatever you need with the result here
    # For now, let's just exit the program

    # Exit program
    li a7, 10         # Load system call number for exit (10)
    ecall             # Perform system call to exit program

    # Declare the array and length in .data
    .data
array:   .word   10, 11, 12, 13, 14, 15    # Array to use
len:     .word   6                           # Length of array
