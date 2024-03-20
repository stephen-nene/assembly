.data
array:   .word   10, 11, 12, 13, 14, 16    # Array to use
len:     .word   6                         # Length of array
sum_msg: .string "Sum is "                 # Message to print before the sum
mean_msg: .string "\nMean is "                 # Message to print before the mean
len_msg: .string "\nLength of array is: \0 and"  # Message to print before the length
sum_result: .word 0                         # Global variable to store the sum


.text
.globl  main
.globl  sum
.globl .mean

main:
    # Load array and length
    la      s0, array        # Load base address of array
    lw      s1, len          # Load length of array

    # Call the add_loop function
    jal     sum
    jal     .mean

    # Exit program
    li      a0, 0            # Exit code
    li      a7, 93           # System call code for exit
    ecall

sum:
    # Save registers to stack
    addi    sp, sp, -16      # Make room on stack
    sw      ra, 0(sp)        # Save return address
    sw      s0, 4(sp)        # Save s0 register
    sw      s1, 8(sp)        # Save s1 register

    # Initialize sum
    li      t0, 0            # Sum register

    # Loop through the array
loop:
    lw      t1, 0(s0)        # Load current element
    add     t0, t0, t1       # Add current element to sum
    addi    s0, s0, 4        # Move to next element
    addi    s1, s1, -1       # Decrement loop counter
    bnez    s1, loop         # Branch if not zero
    
    # Store the sum in the global variable
    la      t2, sum_result   # Load address of sum_result
    sw      t0, 0(t2)        # Store the sum at sum_result


    # Print the message "Sum is"
    la      a0, sum_msg      # Load address of the sum message
    li      a7, 4            # System call code for printing string
    ecall

	# Print the sum
	la      a0, sum_result   # Load address of sum_result
	lw      a0, 0(a0)        # Load the sum from sum_result
	li      a7, 1            # System call code for printing integer
	ecall

    # Restore registers from stack
    lw      ra, 0(sp)        # Restore return address
    lw      s0, 4(sp)        # Restore s0 register
    lw      s1, 8(sp)        # Restore s1 register
    addi    sp, sp, 16       # Restore stack pointer

    jr      ra               # Jump back to the caller
    
 .mean:
    # Save registers to stack
    addi    sp, sp, -16      # Make room on stack
    sw      ra, 0(sp)        # Save return address
    sw      s0, 4(sp)        # Save s0 register
    sw      s1, 8(sp)        # Save s1 register

# Load the sum from the global variable sum_result
la      t0, sum_result   # Load address of sum_result
lw      s0, 0(t0)        # Load the sum from sum_result

# Load the value of len
lw      s1, len          # Load the value of len

# Print the value of len
la      a0, len_msg      # Load address of the len message
li      a7, 4            # System call code for printing string
ecall

# Print the length of the array
lw      a0, len          # Load the value of len
li      a7, 1            # System call code for printing integer
ecall

# Divide sum by length to calculate mean
div     t0, s0, s1       # t0 = sum / length


    # Print the message "Mean is"
    la      a0, mean_msg     # Load address of the mean message
    li      a7, 4            # System call code for printing string
    ecall

    # Print the mean
    mv      a0, t0           # Load mean into argument register
    li      a7, 2            # System call code for printing float
    ecall

    # Restore registers from stack
    lw      ra, 0(sp)        # Restore return address
    lw      s0, 4(sp)        # Restore s0 register
    lw      s1, 8(sp)        # Restore s1 register
    addi    sp, sp, 16       # Restore stack pointer

    jr      ra               # Return to calling function
