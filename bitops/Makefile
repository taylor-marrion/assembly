NAME=bitops

all: bitops

clean:
	rm -rf bitops bitops.o

bitops: bitops.asm
	nasm -f elf -F dwarf -g bitops.asm
	gcc -no-pie -g -m32 -o bitops bitops.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
