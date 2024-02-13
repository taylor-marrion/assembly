%include "/usr/local/share/csc314/asm_io.inc"


segment .data


segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	call read_int  ; 
	mov esi, eax   ; esi
	call read_int  ; eax

	imul esi       ; esi*eax => [edx:]eax

	call print_int ; (edx:eax) eax
	call print_nl ; 

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
