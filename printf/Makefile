NAME=printf

all: printf

clean:
	rm -rf printf printf.o

printf: printf.asm
	nasm -f elf -F dwarf -g printf.asm
	gcc -no-pie -g -m32 -o printf printf.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
