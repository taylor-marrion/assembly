NAME=array_challenge

all: array_challenge

clean:
	rm -rf array_challenge array_challenge.o

array_challenge: array_challenge.asm
	nasm -f elf -F dwarf -g array_challenge.asm
	gcc -no-pie -g -m32 -o array_challenge array_challenge.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
