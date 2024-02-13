%include "/usr/local/share/csc314/asm_io.inc"

;INSERT	/tmp/perms.txt
%define	USER_R	256	;	100000000
%define	USER_W	128	;	010000000
%define	USER_X	64	;	001000000
%define	GROUP_R	32	;	000100000
%define	GROUP_W	16	;	000010000
%define	GROUP_X	8	;	000001000
%define	OTHER_R	4	;	000000100
%define	OTHER_W	2	;	000000010
%define	OTHER_X	1	;	000000001

segment .data

	wasset	db	"Permission granted",10,0
	notset	db	"Ah ah ah, you didn't say the magic word",10,0

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	mov eax, 0x1337
	mov ebx, 0x8675309
	; swap registers
	xor eax, ebx
	xor ebx, eax
	xor eax, ebx

	dump_regs 1

	mov eax, 0
	or eax, USER_R
	or eax, USER_W
	or eax, GROUP_R
	or eax, OTHER_R

	call print_int
	call print_nl

	;----------

	and eax, GROUP_R
	cmp eax, 0
	je bit_not_set
		mov eax, wasset
		call print_string
	jmp end
	bit_not_set:
		mov eax, notset
		call print_string
	end:

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
