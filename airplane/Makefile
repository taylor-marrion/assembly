NAME=airplane

all: airplane

clean:
	rm -rf airplane airplane.o

airplane: airplane.asm
	nasm -f elf -F dwarf -g airplane.asm
	gcc -no-pie -g -m32 -o airplane airplane.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
