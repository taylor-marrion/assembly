NAME=practice1

all: practice1

clean:
	rm -rf practice1 practice1.o

practice1: practice1.asm
	nasm -f elf -F dwarf -g practice1.asm
	gcc -no-pie -g -m32 -o practice1 practice1.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
