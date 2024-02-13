NAME=64bit

all: 64bit

clean:
	rm -rf 64bit 64bit.o

64bit: 64bit.asm
	nasm -f elf64 -F dwarf -g 64bit.asm
	gcc -no-pie -g -m64 -o 64bit 64bit.o -static
