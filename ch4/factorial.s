# PURPOSE:  An example function, using Linux C calling convention. The function
#           we are writing will be the factoria function, i.e. a function to
#           calculate x!
#

.section .data 
.section .text

.globl _start
_start:
  movl $1, %eax   # The exit() system call
  int $0x80

# PURPOSE:    This function is used to calculate the factorial of x. I.e. x!
#
# INPUT:      arg1 - The factorial number
#
# OUTPUT:     x! i.e. ( x*(x-1)*(x-2)*...*2*1 )
#
# NOTES:      The factorial number must be greater than 1
#
# VARIABLES:  
#             %ebx - The factorial number
#             -4(%ebp) - The current result
#             %eax - Temporary storage
.type factorial, @function
factorial: 
  ret                 # Return from the function
