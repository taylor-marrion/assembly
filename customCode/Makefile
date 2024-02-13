NAME=customCode

all: customCode

clean:
	rm -rf customCode customCode.o

customCode: customCode.asm
	nasm -f elf -F dwarf -g customCode.asm
	gcc -no-pie -g -m32 -o customCode customCode.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
