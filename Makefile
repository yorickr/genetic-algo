
CC=g++
CFLAGS=-pedantic -Wextra -Wall
CPPFLAGS=$(CFLAGS) -std=c++11

AR=ar

SRC_DIR=./
OBJ_DIR=./

INCLUDES=-I ./include

LIBRARY=libgenetic-algo.a

SRC=$(shell find ./src -name "*.cpp" -not -name "main.cpp")

OBJ=$(patsubst $(SRC_DIR)%.cpp,$(OBJ_DIR)%.o,$(SRC))

SRC_O=$(shell find ./ -maxdepth 1 -name "*.cpp" -not -name "main.cpp")

OBJ_O=$(patsubst $(SRC_DIR)%.cpp,$(OBJ_DIR)%.o,$(SRC_O))

MAIN=main.o

EXECUTABLE=genetic-algo

release: all

all: CFLAGS+=-O2
all: $(EXECUTABLE) $(LIBRARY)

debug: CFLAGS+=-O0 -g
debug: $(EXECUTABLE)

%.cpp%.o:
	$(CC) -c -o $@ $< $(CPPFLAGS)

# Make the executable named EXECUTABLE using CC with the provided MAIN
$(EXECUTABLE): $(MAIN) $(OBJ) $(OBJ_O)
	$(CC) -o $@ $(CPPFLAGS) $(OBJ) $(MAIN) $(OBJ_O) $(INCLUDES)

# Generate the static library
$(LIBRARY): $(OBJ)
	$(AR) rcs $@ $(OBJ)
	ranlib $@

clean:
	rm -rf $(OBJ)
	rm -rf $(OBJ_O)
	rm -f $(EXECUTABLE)
	rm -f $(MAIN)
	rm -f $(LIBRARY)
