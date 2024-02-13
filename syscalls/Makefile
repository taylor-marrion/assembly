NAME=syscalls

all: syscalls

clean:
	rm -rf syscalls syscalls.o

syscalls: syscalls.asm
	nasm -f elf -F dwarf -g syscalls.asm
	gcc -no-pie -g -m32 -o syscalls syscalls.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
