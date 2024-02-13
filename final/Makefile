NAME=final

all: final

clean:
	rm -rf final final.o

final: final.asm
	nasm -f elf -F dwarf -g final.asm
	gcc -no-pie -g -m32 -o final final.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
