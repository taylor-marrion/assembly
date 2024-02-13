%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	my_array	dd	123,456,789,0

segment .bss

	nums resd 10

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; read 10 ints

	mov ecx, 0
	toploop1:
	cmp ecx, 10
	jge endloop1

		call read_int
		mov DWORD[nums + ecx * 4], eax

	add ecx, 1
	jmp toploop1
	endloop1:

	; print ints

	mov ecx, 0
	toploop2:
	cmp ecx, 10
	jge endloop2

		mov eax, DWORD[nums + ecx * 4]
		call print_int
		call print_nl

	add ecx, 1
	jmp toploop2
	endloop2:

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp,
	ret
