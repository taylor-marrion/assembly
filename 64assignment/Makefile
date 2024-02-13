NAME=64assignment

all: 64assignment

clean:
	rm -rf 64assignment 64assignment.o

64assignment: 64assignment.asm
	nasm -f elf64 -F dwarf -g 64assignment.asm
	gcc -no-pie -g -m64 -o 64assignment 64assignment.o -static
