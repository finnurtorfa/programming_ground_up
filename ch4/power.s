# PURPOSE:  An example function, using Linux C calling convention. The function
#           we are writing will be the power function, i.e. a function to
#           calculate x^y
#

.section .data 
.section .text

.globl _start
_start:
  pushl $3        # The second argument(power number) placed on the stack 
  pushl $2        # The first argument(base number) placed on the stack 
  call power      # Call the power function
  addl $8, %esp   # Move the stack pointer back

  pushl %eax      # Save the first answer on the stack 

  pushl $2        # Second argument(power number)
  pushl $5        # First argument(base number)
  call power      # Call the power function
  addl $8, %esp   # Move the stack pointer back

  popl %ebx       # Pop the first answer off the stack and save it in %ebx

  addl %eax, %ebx # Add the first answer to the second one and store it in %ebx

  movl $1, %eax   # The exit() system call
  int $0x80

# PURPOSE:    This function is used to calculate powers of y over x, i.e. x^y
#
# INPUT:      arg1 - The base number
#             arg2 - The power to raise it to
#
# OUTPUT:     x^y is returned 
#
# NOTES:      The powers must be greater than 0
#
# VARIABLES:  
#             %ebx - The base number
#             %ecx - The power number
#             -4(%ebp) - The current result
#             %eax - Temporary storage
.type power, @function
power: 
  pushl %ebp          # Save old base pointer(return address)
  movl %esp, %ebp     # Make stack pointer the base pointer
  subl $4, %esp       # Make room for our local storage
  
  movl 8(%ebp), %ebx  # Put base number in %ebx
  movl 12(%ebp), %ecx # Put power number in %ecx
  
  movl %ebx, -4(%ebp) # Store current result 

  cmpl $0, %ecx       # Compare the power number to zero 
  je power_power_zero # Jump

  cmpl $0, %ebx       # Compare the base number to zero
  je power_base_zero  # Jump

power_loop:
  cmpl $1, %ecx       # Compare the power number to 1
  je  power_cleanup   # Jump to power cleanup
  movl -4(%ebp), %eax # Move current result into %eax
  imull %ebx, %eax    # Multiply current result with the base number

  movl %eax, -4(%ebp) # Store the current result

  decl %ecx           # Decrease the power number
  jmp power_loop      # Jump back to the beginning of loop 

power_base_zero: 
  movl $0, -4(%ebp)   # Store zero as current result
  jmp power_cleanup

power_power_zero:
  movl $1, -4(%ebp)   # Store 1 as a current result
  jmp power_cleanup

power_cleanup:
  movl -4(%ebp), %eax # Move the result to the %eax register
  movl %ebp, %esp     # Restore the stack pointer
  popl %ebp           # Restore the base pointer
  ret                 # Return from the function
