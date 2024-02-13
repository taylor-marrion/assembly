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

	code_msg	db	"Krabby Patty code is: ",0
	; move everything above this comment to shared resource to %include

	needs_msg	db	"That Krabby Patty needs...",10,0
	no_ingredients_msg	db	"Nothing, just that delicious Krabby Patty!",10,0
	tab_hyphen	db	"    - ",0

	secret	dd	0x706c656b

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; --- receive incoming order code ---
	mov eax, code_msg
	call print_string
	call read_int
	mov DWORD[order], eax

	; --- decrypt order code ---
	mov eax, DWORD[secret]
	xor DWORD[order], eax	; ciphertext xor secret = plaintext
	neg DWORD[order]
	not DWORD[order]
	rol DWORD[order], 13	; comes with a baker's dozen of rolls

	; --- print order ingredients ---
	mov eax, needs_msg
	call print_string

	cmp DWORD[order], 0
	je no_ingredients	;

	mov esi, 128	;	8th bit set, 0b 10000000
	mov ecx, 0		;	counter index

	top_loop:
	cmp ecx, 8
	jge end						;	while (ecx < 8) {
		call print_ingredient	;	print next ingredient
		inc ecx					;	ecx++
		jmp top_loop			;	}

	no_ingredients:
	mov eax, no_ingredients_msg
	call print_string

	end:

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

	print_ingredient:
		mov eax, esi			;
		and eax, DWORD[order]	;	

		cmp eax, esi
		jne next_ingredient
			mov eax, tab_hyphen
			call print_string
			mov eax, DWORD[ingredients + ecx * 4]
			call print_string
			call print_nl

		next_ingredient:
		shr esi, 1		;	128 -> 64 -> 32 -> ... -> 2 -> 1

		ret	;	return
