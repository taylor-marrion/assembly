NAME=sort_ints

all: sort_ints

clean:
	rm -rf sort_ints sort_ints.o

sort_ints: sort_ints.asm
	nasm -f elf -F dwarf -g sort_ints.asm
	gcc -no-pie -g -m32 -o sort_ints sort_ints.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
