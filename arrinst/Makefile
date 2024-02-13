NAME=arrinst

all: arrinst

clean:
	rm -rf arrinst arrinst.o

arrinst: arrinst.asm
	nasm -f elf -F dwarf -g arrinst.asm
	gcc -no-pie -g -m32 -o arrinst arrinst.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
