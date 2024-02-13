NAME=boxes

all: boxes

clean:
	rm -rf boxes boxes.o

boxes: boxes.asm
	nasm -f elf -F dwarf -g boxes.asm
	gcc -no-pie -g -m32 -o boxes boxes.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
