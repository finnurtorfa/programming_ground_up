### Toolchain Commands
##############################

AS = as
LD = ld

### General variables
##############################

SH	= $(shell echo $$0)
RM	= rm -rf
CP	= cp -r
MK	= mkdir -p

### Important Directories
##############################

OBJ_DIR = obj
BUILD_DIRS = obj output
OUTPUT_DIR = output
SRC_DIRS  = .
SRC_DIRS += ch3
SRC_DIRS += ch4
SRC_DIRS += ch5

### Message strings
################################################

MSG_ERRORS_NONE 				= Errors: none
MSG_BEGIN 							= --------- begin ---------
MSG_END 								= ---------  end  ---------
MSG_SIZE_BEFORE 				= Size before: 
MSG_SIZE_AFTER					= Size after:
MSG_LINKING 						= Linking:
MSG_ASSEMBLING 					= Assembling:
MSG_CLEANING 						= Cleaning project:
MSG_CREATING_LIBRARY		= Creating library:
MSG_CREATING_BUILD_DIRS	= Creating build directory:

### Source files
### List them without directory extensions
################################################

# Lists
AS_SRC  = exit.s
AS_SRC += max.s
AS_SRC += max2.s
AS_SRC += factorial.s
AS_SRC += power.s
AS_SRC += square.s
AS_SRC += factorial_nonrecursive.s

### Set source lookup paths
################################################

vpath %.s $(SRC_DIRS)

### Object files
################################################

OBJ = $(addprefix $(OBJ_DIR)/, $(AS_SRC:.s=.o))

### Rules
###
### Rules are formatted in the following manner,
### all but the target are optional:
### target : dependencies
###		command
###		...
###		...
###	
################################################

# Default rule target
.PHONY: all
.PRECIOUS : $(OBJ)
all: begin $(BUILD_DIRS) $(OBJ) end

# Compile: create object files from C source files.
$(OBJ_DIR)/%.o : %.s
	@echo
	@echo $(MSG_COMPILING) $<
	$(AS) $< -o $@ 
	$(LD) $@ $(LD_FLAGS) -o $(OUTPUT_DIR)/$(notdir $(@:.o=.out))

# Target: create build directories
$(BUILD_DIRS) : 
	@echo
	@echo $(MSG_CREATING_BUILD_DIRS)
	- $(MK) $@

# Target: clean project.
clean: begin clean_list end

clean_list :
	@echo
	@echo $(MSG_CLEANING)
	$(RM) $(BUILD_DIRS)

begin : 
	@echo
	@echo $(MSG_BEGIN)

end :
	@echo
	@echo $(MSG_END)
