NAME=movaddsub

all: movaddsub

clean:
	rm -rf movaddsub movaddsub.o

movaddsub: movaddsub.asm
	nasm -f elf -F dwarf -g movaddsub.asm
	gcc -no-pie -g -m32 -o movaddsub movaddsub.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
