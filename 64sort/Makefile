NAME=64sort

all: 64sort

clean:
	rm -rf 64sort 64sort.o

64sort: 64sort.asm
	nasm -f elf64 -F dwarf -g 64sort.asm
	gcc -no-pie -g -m64 -o 64sort 64sort.o -static
