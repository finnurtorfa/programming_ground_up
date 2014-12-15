Examples and exercises from Programming from the Ground UP
======

Here I store examples and exercises for the book 'Programming from the Ground 
Up' by Jonathan Bartlett. The book covers topics on programming in Linux 
assembly language on x86 architecture.

This file also stores some of my notes for easy referrals later on.

Sections
-----

A program is usually broken up into different sections. A new section is added
by using the *.section* directive. Below is a listing of some important
sections: 

*   .data. The data section is used to list any memory storage needed for data.
    The *data* section takes up space in the final executable and should be used
    for initialized data.
*   .bss. It is similar to the *data* section, except it doesn't take up any
    space inthe executable and is used for uninitialized data like buffers and
    such.
*   .text. The text section is where your program instructions live.

Data Accessing Modes 
-----

This section discusses data accessing modes, with some examples.

The general format for an address references is the following:

    ADDRESS_OR_OFFSET(%BASE_OR_OFFSET, %INDEX, %INDEX_MULTIPLIER)

All of the fields are optional and to calculate the final address just use the
following formula:

    FINAL_ADDR = ADDRESS_OR_OFFSET + BASE_OR_OFFSET + INDEX_MULTIPLIER * INDEX

### Register Addressing Mode

Instruction contains a register to address. All other addressing modes will deal
with addresses. 

    movl %ebx, %eax

This instruction simply moves whatever is in the *ebx* register into the *eax*
register.

### Direct Addressing Mode

Intstruction contains a memory address to access. E.g.

    movl ADDRESS_OR_OFFSET, %eax
    movl 1, %eax

These instructions tell the assembler to move whatever is located at address
ADDRESS\_OR\_OFFSET or address 1 into the *eax* register

### Indexed Addressing Mode

Same as **Direct Addressing Mode** except the instruction also contains an
*index register* as an offset to the address given. It is also possible to
specify a *multiplier* to the *index register* to access memory a byte at a
time or a word at a time. On x86 architectures a *word* equals 4 bytes. E.g.

    movl ADDRESS_OR_OFFSET(, %INDEX, %INDEX_MULTIPLIER), %eax

This instruction tells the assembler to move what is located at address 

    ADDRESS_OR_OFFSET + INDEX * INDEX_MULTIPLIER

into the *eax* register.

### Indirect Addressing Mode

The instruction contains a register which contains a *pointer* to where the 
data should be accessed. *Pointers* are memory addresses. E.g.

    movl (%ebx), %eax

Let's say that the *ebx* register held an address. Then this instruction tells
the assembler to load whatever is located in that address into the *eax*
register.

### Base Pointer Addressing Mode

This is similar to the **Indirect Addressing Mode** except that you include an
*offset* to add to the registers value before lookup.

    movl 4 (%ebx), %eax

This is similar to Indirect addressing mode, except that we add an *offset* of 4
to the address held in *ebx* and move whatever was located at that address into
the *eax* register.

### Immediate Addressing Mode

The instruction contains a value instead of an address. Prefixing with a
dollar($) sign is a way to tell the assembler that you intend to use the value
instead of address. E.g.

    movl $1, %eax

This instruction tells the assembler to move the value 1 to the *eax* register.

Memory location size directives
-----

### .byte

Takes up 1 memory storage location(1 byte)

### .int

Takes up 2 memory storage locations(2 bytes)


### .long

Takes up 4 memory storage locations(4 bytes)

### .ascii

Takes up 1 memoty storage location(1 byte), but is used for character
representation(ASCII format).

File Handling using the UNIX file concept
-----

To open and read/write/create etc. a file under unix it is necessary to follow 4
easy steps:

1.  Use the system call number 5, which takes filename, mode and permissions as
    argument. To do this move the literal 5 to the *eax* register.

    *   Address of the first character of the filename is stored in *ebx*
        register. 
    *   The **mode** is stored in the *ecx* register.
    *   The **permission** is stored in *edx* register. 
2.  Linux will then return a **file descriptor** which stored in the *eax*
    register. This is used throughout the program to refer to the file.
3.  Operate on the file. To read it use system call number 3, and to write use
    system call number 4. They both take the same arguments.

    *   The file descriptor retrieved earlier is stored in the *ebx* register. 
    *   An address of a **buffer** for I/O operations is stored in the *ecx*
        register. 
    *   The size of the buffer is stored in *edx* register.
4.  When done, close the file by using system call number 6. The file descriptor
    is stored in the *ebx* register.

