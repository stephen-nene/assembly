.data
array:   .word   10, 11, 12, 13, 14, 15    # Array to use
len:     .word   6                         # Length of array
sum_msg: .string "Sum is "                 # Message to print before the sum
mean_msg: .string "Mean is "               # Message to print before the mean

.text
.globl  main

main:
    # Save registers to stack
    addi    sp, sp, -16      # Make room on stack
    sw      ra, 0(sp)        # Save return address
    sw      s0, 4(sp)        # Save s0 register
    sw      s1, 8(sp)        # Save s1 register

    # Load array and length
    la      s0, array        # Load base address of array
    lw      s1, len          # Load length of array

    # Initialize sum
    li      t0, 0            # Sum register
    


sum:
    lw      t1, 0(s0)        # Load current element
    add     t0, t0, t1       # Add current element to sum
    addi    s0, s0, 4        # Move to next element
    addi    s1, s1, -1       # Decrement loop counter
    bnez    s1, sum     # Branch if not zero

    # Print the message "Sum is"
    la      a0, sum_msg      # Load address of the sum message
    li      a7, 4            # System call code for printing string
    ecall

    # Print the sum
    mv      a0, t0           # Load sum into argument register
    li      a7, 1            # System call code for printing integer
    ecall

    # Restore registers from stack
    lw      ra, 0(sp)        # Restore return address
    lw      s0, 4(sp)        # Restore s0 register
    lw      s1, 8(sp)        # Restore s1 register
    addi    sp, sp, 16       # Restore stack pointer

    # Exit program
    li      a0, 0            # Exit code
    li      a7, 93           # System call code for exit
    ecall


mean:
