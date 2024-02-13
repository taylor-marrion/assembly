%include "/usr/local/share/csc314/asm_io.inc"

segment .data

	order	dd	0	;	32 bits; extra space for encryption

	bun		db	"Bun",0
	cheese	db	"Cheese",0
	lettuce	db	"Lettuce",0
	onion	db	"Onion",0
	tomato	db	"Tomato",0
	pickles	db	"Pickles",0
	mustard	db	"Mustard",0
	ketchup	db	"Ketchup",0

	ingredients	dd	bun, cheese, lettuce, onion, tomato, pickles, mustard, ketchup

	; move the ingredients to separate file that order/cook %include
	question_colon	db	"?: ",0

	code_msg	db	"Krabby Patty code is: ",0

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; no code needed, this is just for the segment .data

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
