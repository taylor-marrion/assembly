NAME=strlen

all: strlen

clean:
	rm -rf strlen strlen.o

strlen: strlen.asm
	nasm -f elf -F dwarf -g strlen.asm
	gcc -no-pie -g -m32 -o strlen strlen.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
