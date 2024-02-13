NAME=function_challenge

all: function_challenge

clean:
	rm -rf function_challenge function_challenge.o

function_challenge: function_challenge.asm
	nasm -f elf -F dwarf -g function_challenge.asm
	gcc -no-pie -g -m32 -o function_challenge function_challenge.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
