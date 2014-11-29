Examples and exercises from Programming from the Ground UP
======

Here I store examples and exercises for the book 'Programming from the Ground 
Up' by Jonathan Bartlett. The book covers topics on programming in Linux 
assembly language on x86 architecture.

This file also stores some of my notes for easy referrals later on.

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


