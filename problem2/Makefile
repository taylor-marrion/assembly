NAME=problem2

all: problem2

clean:
	rm -rf problem2 problem2.o

problem2: problem2.asm
	nasm -f elf -F dwarf -g problem2.asm
	gcc -no-pie -g -m32 -o problem2 problem2.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
