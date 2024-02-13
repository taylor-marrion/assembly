NAME=practice1_2

all: practice1_2

clean:
	rm -rf practice1_2 practice1_2.o

practice1_2: practice1_2.asm
	nasm -f elf -F dwarf -g practice1_2.asm
	gcc -no-pie -g -m32 -o practice1_2 practice1_2.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
