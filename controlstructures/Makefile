NAME=controlstructures

all: controlstructures

clean:
	rm -rf controlstructures controlstructures.o

controlstructures: controlstructures.asm
	nasm -f elf -F dwarf -g controlstructures.asm
	gcc -no-pie -g -m32 -o controlstructures controlstructures.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
