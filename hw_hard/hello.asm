
segment .data

	mystring db "Hello world",10,0

segment .text

global _start

_start:
	mov	eax, 4
	mov ebx, 1
	mov ecx, mystring
	mov edx, 12
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80

	ret
