# Function to print each element of the array with its index position
.text
print_array:
    # Save necessary registers to the stack
    addi sp, sp, -8     # Allocate space on the stack
    sw ra, 4(sp)        # Save return address
    sw s0, 0(sp)        # Save s0 register

    # Initialize loop counter and array pointer
    li s0, 0            # Loop counter
    la t0, array        # Load address of array into t0

loop:
    bge s0, x6, end     # If loop counter >= array length, exit loop

    # Print index and value
    mv a0, s0           # Move index to argument register
    ecall               # Print index
    lw a0, 0(t0)        # Load array element into a0
    ecall               # Print value
    li a0, '\n'         # Load newline character into a0
    ecall               # Print newline

    # Increment loop counter and array pointer
    addi s0, s0, 1      # Increment loop counter
    addi t0, t0, 4      # Move to the next element of the array

    j loop              # Jump back to loop

end:
    # Restore saved registers
    lw s0, 0(sp)        # Restore s0 register
    lw ra, 4(sp)        # Restore return address
    addi sp, sp, 8      # Deallocate space on the stack

    ret
