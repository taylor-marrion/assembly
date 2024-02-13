NAME=libc

all: libc

clean:
	rm -rf libc libc.o

libc: libc.asm
	nasm -f elf -F dwarf -g libc.asm
	gcc -no-pie -g -m32 -o libc libc.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
