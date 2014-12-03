# PURPOSE:  A function, using Linux C calling convention. The function 
#           we are writing will be the square function, i.e. a function to
#           calculate x^2
#

.section .data 
.section .text

.globl _start
_start:
  pushl $4        # The input number
  call square
  addl $4, %esp   # Move the stack pointer back

  movl %eax, %ebx # Accordind to C calling convention return value is stored in
                  # %eax. Linux however dictates that status code be stored in
                  # %ebx.
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
  pushl %ebp            # Save old base pointer
  movl %esp, %ebp       # Make stack pointer the base pointer
  movl 8(%ebp), %eax    # Put the input number in %eax

  imull %eax, %eax      # Multiply the input number with itself and store in
                        # %eax

square_cleanup:
  movl %ebp, %esp  # Restore the stack pointer
  popl %ebp        # Restore the base pointer
  ret              # Return from the function
