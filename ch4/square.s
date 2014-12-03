# PURPOSE:  A function, using Linux C calling convention. The function 
#           we are writing will be the square function, i.e. a function to
#           calculate x^2
#

.section .data 
.section .text

.globl _start
_start:
  movl $1, %eax   # The exit() system call
  int $0x80

# PURPOSE:    This function is used to calculate the square of x. I.e. x^2
#
# INPUT:      arg1 - The number used to calculate the square
#
# OUTPUT:     x^2
#
# VARIABLES:  
#             %ebx - The square
.type square, @function
square: 
  movl %ebp, %esp  # Restore the stack pointer
  popl %ebp        # Restore the base pointer
  ret              # Return from the function
