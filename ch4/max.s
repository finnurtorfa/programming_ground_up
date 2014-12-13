# PURPOSE:  A function to find the largest element in a list
#
.section .data

list1: 
  .long 3, 67, 1, 10, 77, 12, 222, 22, 54, 22, 11, 250, 66, 23, 0

list2: 
  .long 20, 30, 40, 50, 10, 100, 80, 60, 150, 25, 35, 0

list3: 
  .long 1, 2, 3, 4, 5, 10, 8, 100, 9, 9, 20, 0

.section .text 
.globl _start
_start: 
  pushl $list1    # Push the address of the beginning of list1
                  # onto the stack. It will by the argument.
  call maximum 
  addl $4, %esp   # Move the stack pointer back

  pushl $list2    # Push the address of the beginning of list1
                  # onto the stack. It will by the argument.
  call maximum 
  addl $4, %esp   # Move the stack pointer back

  pushl $list3    # Push the address of the beginning of list1
                  # onto the stack. It will by the argument.
  call maximum 
  addl $4, %esp   # Move the stack pointer back

  movl %eax, %ebx # The first item is the current largest
                  # item
  movl $1, %eax   # 1 stands for the exit() system call
  int $0x80       # This wakes up the kernel to run the exit command

# PURPOSE:    A function to find the largest element in a list
#
# INPUT:      arg1 - A pointer to the beginning of the list
#
# OUTPUT:     The maximum value of the list
#
# VARIABLES:  
#             %ebx - Pointer to the address of the list
#             %eax - Maximum number
.type maximum, @function
maximum: 
  pushl %ebp          # Save old base pointer(return address)
  movl %esp, %ebp     # Make stack pointer the base pointer
  
  movl 8(%ebp), %ebx  # Put pointer address in %ebx
  movl (%ebx), %eax   # Put the data pointed to by the address in %ebx in %eax

maximum_loop:
  cmpl $0, (%ebx)
  je maximum_exit

  addl $4, %ebx       # Add 4 to the address, so it points to the next item

  cmpl %eax, (%ebx)   # Compare the current largest value to the data pointed to
                      # by the address in %ebx
  jle maximum_loop    # Jump to beginning of loop if it isn't larger
  movl (%ebx), %eax   # Move the larger value into %eax
  jmp maximum_loop    # Jump to beginning of loop

maximum_exit:
  movl %ebp, %esp     # Restore the stack pointer
  popl %ebp           # Restore the base pointer
  ret
