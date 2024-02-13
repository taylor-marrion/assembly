NAME=cook

all: cook

clean:
	rm -rf cook cook.o

cook: cook.asm
	nasm -f elf -F dwarf -g cook.asm
	gcc -no-pie -g -m32 -o cook cook.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
