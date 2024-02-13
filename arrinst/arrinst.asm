%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	buff1	db		"Baylor",0
	buff3	db		"Taylor",0

	wereequal	db	"The strings were equal",10,0
	notequal	db	"The strings were not equal",10,0

segment .bss

	buff2	resb	7

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	cld

	; ex 1
	mov esi, buff1
	mov edi, buff2
	toploop:
		lodsb	;	BYTE [esi] -> al / esi++
		stosb	;	al -> BYTE [edi] / edi++

	cmp al, 0	;	if al is not null byte
	jne toploop

	mov eax, buff2
	call print_string
	call print_nl

	; ex 2
	mov esi, buff1
	mov edi, buff3
	toploop2:
		cmpsb
		jne	print_ne

	cmp BYTE[edi-1], 0
	jne toploop2
		mov eax, wereequal
		call print_string
	jmp endprog

	print_ne:
		mov eax, notequal
		call print_string

	endprog:

	; ex 3
	mov esi, buff1
	mov edi, buff2
	mov ecx, 7
	rep movsb

	mov eax, edi
	call print_string

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
