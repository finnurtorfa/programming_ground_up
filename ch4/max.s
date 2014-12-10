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
  movl $1, %eax     # 1 stands for the exit() system call
  int $0x80         # This wakes up the kernel to run the exit command

# PURPOSE:    A function to find the largest element in a list
#
# INPUT:      arg1 - A pointer to the beginning of the list
#
# OUTPUT:     The maximum value of the list
#
# VARIABLES:  
#             %ebx - The maximum number
#             %eax - Temporary storage
.type maximum, @function
maximum: 
