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
	mov ebx, eax  ; ebx = b
	call read_int ; eax = a

	cdq			; edx:eax = b
	idiv ebx 		; 
	add eax, ebx	; ebx += eax 

	call print_int
	call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
