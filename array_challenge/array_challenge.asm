%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	str1	db		"I<3CSC314",0
	str2	db		"Winner winner!",10,0
	str3	db		"Nope :(",10,0

segment .bss

	buff1	resd	10
	buff2	resb	10

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	mov		edi, buff1
	mov		ecx, 10
	cld
	loop_1:
		call	read_int
		cmp		eax, 1000
		jl		fail
		stosd
		dec		ecx
	cmp		ecx, 0
	jg		loop_1

	mov		ebx, 256
	mov		esi, buff1
	mov		edi, buff2
	mov		ecx, 10
	cld
	loop_2:
		lodsd
		cdq
		idiv	ebx
		mov		al, dl
		stosb
		dec		ecx
	cmp		ecx, 0
	jg		loop_2

	mov		esi, buff2
	mov		edi, str1
	mov		ecx, 10
	cld
	repe	cmpsb
	jne		fail
		mov		eax, str2
		jmp		end
	fail:
		mov		eax, str3
	end:
	call	print_string

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

