# PURPOSE:    Search for the largest item in a list of data
#
# INPUT:      None
#
# OUTPUT:     Returns a status code. The status code will hold the maximum 
#             value in the list
#
# VARIABLES:  
#             %edi holds the index of the data items
#             %eax holds the current data item
#             %ebx holds the largest data item
#             
#             Following memory locations are used:
#             
#             data_items - contains the item data. A 0 is used to indicate the
#                          end of the list
.section .data

data_items: 
  .long 3, 67, 1, 10, 77, 12, 222, 22, 54, 22, 11, 250, 66, 23, 0

.section .text 
.globl _start
_start: 
  movl $0, %edi                     # Move 0 into the index register.
  movl data_items(, %edi, 4), %eax  # Move the first byte of data from 
                                    # data_items to %eax
  movl %eax, %ebx                   # The first item is the current largest
                                    # item

max_loop: 
  cmpl $0, %eax                     # Are we at the end of the list?
  je max_loop_exit                  # Jump to max_loop_exit
  incl %edi                         # Increment the %edi register
  movl data_items(, %edi, 4), %eax  # Move the next byte of data from 
                                    # data_items to %eax
  cmpl %ebx, %eax                   # Compare the current value to the largest
                                    # value
  jle max_loop                      # Jump to the beginning of the loop if the
                                    # value isn't larger
  movl %eax, %ebx                   # Move the larger value to %ebx
  jmp max_loop                      # Jump to the beginning of the loop

max_loop_exit: 
  movl $1, %eax     # 1 stands for the exit() system call
  int $0x80         # This wakes up the kernel to run the exit command
