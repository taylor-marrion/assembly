%include "/usr/local/share/csc314/asm_io.inc"


segment .data


segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	call read_int ; 
	mov ebx, eax  ; cyber2 -> ebx
	call read_int ; cyber1 -> eax

	add eax, eax  ; cyber4 = cyber1 + cyber1
	sub eax, ebx  ; cyber4 -= cyber2
	add eax, 1337 ; cyber4 += 1337
	add eax, 9    ; cyber4+= 9

	call print_int;

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
