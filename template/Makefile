NAME=template

all: template

clean:
	rm -rf template template.o

template: template.asm
	nasm -f elf -F dwarf -g template.asm
	gcc -no-pie -g -m32 -o template template.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
