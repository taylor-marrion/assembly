NAME=customCode2

all: customCode2

clean:
	rm -rf customCode2 customCode2.o

customCode2: customCode2.asm
	nasm -f elf -F dwarf -g customCode2.asm
	gcc -no-pie -g -m32 -o customCode2 customCode2.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
