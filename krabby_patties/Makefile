NAME=krabby_patties

all: krabby_patties

clean:
	rm -rf krabby_patties krabby_patties.o

krabby_patties: krabby_patties.asm
	nasm -f elf -F dwarf -g krabby_patties.asm
	gcc -no-pie -g -m32 -o krabby_patties krabby_patties.o /usr/local/share/csc314/driver.c /usr/local/share/csc314/asm_io.o
