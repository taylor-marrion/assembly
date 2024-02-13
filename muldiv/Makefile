NAME=muldiv

all: muldiv

clean:
	rm -rf muldiv muldiv.o

muldiv: muldiv.asm
	nasm -f elf -F dwarf -g muldiv.asm
	gcc -no-pie -g -m32 -o muldiv muldiv.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
