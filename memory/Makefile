NAME=memory

all: memory

clean:
	rm -rf memory memory.o

memory: memory.asm
	nasm -f elf -F dwarf -g memory.asm
	gcc -no-pie -g -m32 -o memory memory.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
