## Maths .ASM

*   Create the RISC-V Assembly code for the following questions and add the results to one file.
*   Note that it is important to save register data to the stack and then restore it when dealing with functions.

## instructions

Declare the array and length in .data

```plaintext
.data

array:   .word   10, 11, 12, 13, 14, 15    # Array to use

len:   .word.   6.  # Length of array
```

## Questions

## 1\. Sum

*   Create a function named sum which sums a double precision array.
*   The starting address of the array and the size (int) of the array are input arguments to the function.
*   The sum (double) is returned from the function.

## 2\. Mean

*   Create a function named mean which determines the mean of a double precision array.
*   The starting address of the array and the size (int) of the array are input arguments to the function.
*   The mean (double) is returned from the function. This function should use the sum function.

## 3\. PrintArray

*   Create a function named printArray which prints an array to stdout (in a formated way (ie. A=\[1,2,3\]))
*   The starting address of the array and the size (int) of the array are input arguments to the function.
*   Nothing is returned from the function.

## 4\. Main

*   Create a program named main which initializes an array and tests the 3 functions (sum, mean, and printArray).