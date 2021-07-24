# Make File for Read Log Update

######### Build Params #################
DEBUG		= 1
VERBOSITY	= 4
MKDIR_P 	= mkdir -p
DECOMPILE	= 0
CC = clang++
BINARY_NAME = rlu_driver

# Build Dir
BUILD_DIR	= build
OBJ_DIR		= obj

# Source Dirs
INC_DIR		= include
SRC_DIR		= src
DEPS			= $(INC_DIR)/rlu_driver.h $(INC_DIR)/tracer.h

###### Compilation Flags  #####################
CFLAGS		= -std=c++14 -DVERBOSITY=$(VERBOSITY)

CFLAGS_COMMON = -fwrapv \
	-Weverything -Wall -Werror -Wshadow -Wextra -Wunused
CFLAGS_STUDENT_CLANGALYZER =  -Wno-c++98-compat-pedantic \
	-Wno-extra-semi-stmt
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
SANITY_COMPILER_FLAGS = $(CFLAGS_COMMON) $(CFLAGS_STUDENT_CLANGALYZER)

######### Libraries ########
LIBS	=

######### Main Build ##################
.PHONY: build setup compile clean doc extractROM install docs

build: setup compile

compile: $(BUILD_DIR)/$(OBJ_DIR)/rlu_driver.o
	$(CC) -o $(BINARY_NAME) $^ $(CFLAGS) $(SANITY_COMPILER_FLAGS)

$(BUILD_DIR)/$(OBJ_DIR)/rlu_driver.o: $(SRC_DIR)/rlu_driver.cc $(DEPS)
	$(CC) -c -o $@ -I$(INC_DIR) $< $(CFLAGS) $(SANITY_COMPILER_FLAGS)

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
	find $(INC_DIR)/ -iname *.h | xargs clang-format -i
	find $(SRC_DIR)/ -iname *.cc | xargs clang-format -i
	-rm -rf $(BUILD_DIR) core
	-rm rlu_driver
	-rm doxygen_warning
