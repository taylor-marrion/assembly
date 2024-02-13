NAME=calculator

all: calculator

clean:
	rm -rf calculator calculator.o

calculator: calculator.asm
	nasm -f elf -F dwarf -g calculator.asm
	gcc -no-pie -g -m32 -o calculator calculator.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
