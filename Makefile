CC = gcc
MKDIR_P = mkdir -p

CFLAGS = -Wall -g -O2 -Wno-unused-function
LDFLAGS = -lz

VENDOR = vendor
SRC = src
BIN = bin
TEST_D = test_files

OBJS := $(SRC)/aln.o \
	$(SRC)/rseq.o \
        $(VENDOR)/tommyarray.o \
        $(VENDOR)/tommyhashlin.o \
        $(VENDOR)/tommyhash.o \
        $(VENDOR)/tommylist.o

.PHONY: all
.PHONY: clean
.PHONY: test

all: bin_dir pasv

bin_dir:
	$(MKDIR_P) $(BIN)

pasv: $(OBJS)
	$(CC) $(CFLAGS) -o $(BIN)/$@ $^ $(SRC)/$@.c $(LDFLAGS) -lpthread

clean:
	-rm -r $(BIN) $(OBJS) *.o

test: pasv
	-rm -r output
	$(BIN)/pasv -d output -o output -t 4 -r test_files/refs.fa -q test_files/queries.fa -s 700 -e 800 762 763

lala: $(OBJS)
	$(CC) $(CFLAGS) -o $(BIN)/$@ $^ $(SRC)/$@.c $(LDFLAGS)
