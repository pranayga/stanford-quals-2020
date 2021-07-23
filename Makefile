# Make File for Read Log Update

######### Build Params #################
DEBUG		= 1
MKDIR_P 	= mkdir -p
DECOMPILE	= 0
CC = clang++

# Build Dir
BUILD_DIR	= build
OBJ_DIR		= obj

# Source Dirs
INC_DIR		= include
SRC_DIR		= src
DEPS			= $(INC_DIR)/hello.h $(INC_DIR)/debug.h

###### Compilation Flags  #####################
CFLAGS		=

CFLAGS_COMMON = -fwrapv \
	-Wall -Werror -Wshadow -Wextra -Wunused
CFLAGS_STUDENT_CLANGALYZER = -pedantic-errors -Weverything \
	-Wno-reserved-id-macro -Wno-unused-macros \
	-Wno-documentation -Wno-documentation-unknown-command \
	-Wno-cast-align -Wno-padded \
	-Wno-unused-parameter \
	-Wno-pointer-arith \
	-Wno-shift-sign-overflow \
	-Wno-vla \
	-Wno-missing-noreturn

# DEBUGGING is enabled by default, you can reduce binary size by disabling the
# DEBUGGING
ifeq ($(DEBUG), 1)
	DEFINE_MACROS 	= -DDEBUG -g
	OPTIMIZATION  	= -O0
else
	OPTIMIZATION 	= -O3 -finline-functions
endif

ifeq ($(DECOMPILE), 1)
	DEFINE_MACROS 	+= -D DECOMPILE
endif

CFLAGS += $(OPTIMIZATION) $(DEFINE_MACROS)

######### Libraries ########
LIBS 					=

######### Main Build ##################
.PHONY: build setup compile clean doc extractROM install docs

build: setup compile

compile: $(BUILD_DIR)/$(OBJ_DIR)/hello.o
	$(CC) -o invaders $^ $(CFLAGS)

$(BUILD_DIR)/$(OBJ_DIR)/hello.o: $(SRC_DIR)/hello.cpp $(DEPS)
	$(CC) -c -o $@ -I$(INC_DIR) $< $(CFLAGS) $(COMPILER_ERROR_FLAGS)

######### Dependency Install ##########
install:
	sudo apt update
	sudo apt install build-essential clang clang-format

######### Make Docs ###################
docs: setup
	doxygen docs/Doxyfile

######### RPM Extraction Rules ########
setup:
	$(MKDIR_P) $(BUILD_DIR)
	$(MKDIR_P) $(BUILD_DIR)/$(OBJ_DIR)
	
######### Clean UP Rules ##############
clean:
	-rm -rf $(BUILD_DIR) core
	-rm doxygen_warning
