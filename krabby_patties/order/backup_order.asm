%include "/usr/local/share/csc314/asm_io.inc"

%define	BUN		128	;	10000000
%define	CHEESE	64	;	01000000
%define	LETTUCE	32	;	00100000
%define	ONION	16	;	00010000
%define	TOMATO	8	;	00001000
%define	PICKLES	4	;	00000100
%define	MUSTARD	2	;	00000010
%define	KETCHUP	1	;	00000001

segment .data

	order	dd	0	;	32 bits
					;	longer than it needs to be,
					;	extra space for encryption
	bun		db	"Bun?: ",0
	cheese	db	"Cheese?: ",0
	lettuce	db	"Lettuce?: ",0
	onion	db	"Onion?: ",0
	tomato	db	"Tomato?: ",0
	pickles	db	"Pickles?: ",0
	mustard	db	"Mustard?: ",0
	ketchup	db	"Ketchup?: ",0

	code_msg	db	"Krabby Patty code is: ",0

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; Take order
	mov eax, bun
	call print_string
	call read_char
	cmp al, 'y'
		jne ask_cheese	;	anything else will be read as "no"
		or DWORD[order], BUN	;	 must be in this order

	ask_cheese:
	call read_char	;	\n from last read_char
	mov eax, cheese
	call print_string
	call read_char
	cmp al, 'y'
		jne ask_lettuce
		or DWORD[order], CHEESE

	ask_lettuce:
	call read_char
	mov eax, lettuce
	call print_string
	call read_char
	cmp al, 'y'
		jne ask_onion
		or DWORD[order], LETTUCE

	ask_onion:
	call read_char
	mov eax, onion
	call print_string
	call read_char
	cmp al, 'y'
		jne ask_tomato
		or DWORD[order], ONION

	ask_tomato:
	call read_char
	mov eax, tomato
	call print_string
	call read_char
	cmp al, 'y'
		jne ask_pickles
		or DWORD[order], TOMATO

	ask_pickles:
	call read_char
	mov eax, pickles
	call print_string
	call read_char
	cmp al, 'y'
		jne ask_mustard
		or DWORD[order], PICKLES

	ask_mustard:
	call read_char
	mov eax, mustard
	call print_string
	call read_char
	cmp al, 'y'
		jne ask_ketchup
		or DWORD[order], MUSTARD

	ask_ketchup:
	call read_char
	mov eax, ketchup
	call print_string
	call read_char
	cmp al, 'y'
		jne encrypt
		or DWORD[order], KETCHUP

	; encrypt order before sending to Spongebob
	encrypt:
	

	; print final encrypted order code
	mov eax, code_msg
	call print_string
	mov eax, DWORD[order]
	call print_int
	call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
