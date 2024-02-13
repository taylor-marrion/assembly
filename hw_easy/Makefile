NAME=hw_easy

all: hw_easy

clean:
	rm -rf hw_easy hw_easy.o

hw_easy: hw_easy.asm
	nasm -f elf -F dwarf -g hw_easy.asm
	gcc -g -m32 -o hw_easy hw_easy.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
