NAME=functions

all: functions

clean:
	rm -rf functions functions.o

functions: functions.asm
	nasm -f elf -F dwarf -g functions.asm
	gcc -no-pie -g -m32 -o functions functions.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
