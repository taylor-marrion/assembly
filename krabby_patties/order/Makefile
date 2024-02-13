NAME=order

all: order

clean:
	rm -rf order order.o

order: order.asm
	nasm -f elf -F dwarf -g order.asm
	gcc -no-pie -g -m32 -o order order.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
