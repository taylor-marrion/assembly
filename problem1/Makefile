NAME=problem1

all: problem1

clean:
	rm -rf problem1 problem1.o

problem1: problem1.asm
	nasm -f elf -F dwarf -g problem1.asm
	gcc -no-pie -g -m32 -o problem1 problem1.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
