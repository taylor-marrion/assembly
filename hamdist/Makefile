NAME=hamdist

all: hamdist

clean:
	rm -rf hamdist hamdist.o

hamdist: hamdist.asm
	nasm -f elf -F dwarf -g hamdist.asm
	gcc -no-pie -g -m32 -o hamdist hamdist.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
