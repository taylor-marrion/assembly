NAME=product

all: product

clean:
	rm -rf product product.o

product: product.asm
	nasm -f elf -F dwarf -g product.asm
	gcc -no-pie -g -m32 -o product product.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
