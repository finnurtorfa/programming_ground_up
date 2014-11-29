Examples and exercises from Programming from the Ground UP
======

Here I store examples and exercises for the book 'Programming from the Ground 
Up' by Jonathan Bartlett. The book covers topics on programming in Linux 
assembly language on x86 architecture.

This file also stores some of my notes for easy referrals later on.

Data Accessing Modes 
-----

This section discusses data accessing modes, with some examples.

### Register Addressing Mode

Instruction contains a register to address. All other addressing modes will deal
with addresses. 

### Direct Addressing Mode

Intstruction contains a memory address to access. E.g.

    movl 1, %eax

This instruction tells the assembler to move whatever is located at address 1
into the *eax* general purpose register.

### Indexed Addressing Mode

Same as **Direct Addressing Mode** except the instruction also contains an
*index register* as an offset to the address given. It is also possible to
specify a *multiplier* to the *index register* to access memory a byte at a
time or a word at a time. On x86 architectures a *word* equals 4 bytes.

### Indirect Addressing Mode

The instruction contains a register which contains a *pointer* to where the 
data should be accessed. *Pointers* are memory addresses.

### Base Pointer Addressing Mode

This is similar to the **Indirect Addressing Mode** except that you include an
*offset* to add to the registers value before lookup.

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


