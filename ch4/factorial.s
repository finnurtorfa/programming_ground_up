# PURPOSE:  An example function, using Linux C calling convention. The function
#           we are writing will be the factoria function, i.e. a function to
#           calculate x!
#

.section .data 
.section .text

.globl _start
_start:
  pushl $4        # The factorial number
  call factorial
  addl $4, %esp   # Move the stack pointer back

  movl %eax, %ebx # Accordind to C calling convention return value is stored in
                  # %eax. Linux however dictates that status code be stored in
                  # %ebx.
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
#             %eax - Temporary storage
.type factorial, @function
factorial: 
  pushl %ebp            # Save old base pointer
  movl %esp, %ebp       # Make stack pointer the base pointer
  movl 8(%ebp), %eax    # Put the factorial number in %eax

  cmpl $1, %eax         # Check if we have reached 1
  je factorial_cleanup  # Clean up if so

  decl %eax             # Decrement the factorial number
  pushl %eax            # Push the new factorial number on the stack
  call factorial        # Call the factorial function with decremented factorial
                        # number
  movl 8(%ebp), %ebx    # Reload parameter into %ebx

  imull %ebx, %eax      # Multiply the result with the factorial number and
                        # store in %eax

factorial_cleanup:
  movl %ebp, %esp  # Restore the stack pointer
  popl %ebp        # Restore the base pointer
  ret              # Return from the function
