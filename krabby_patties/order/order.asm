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

	question_colon	db	"?: ",0

	secret	dd	0x706c656b

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	mov esi, 128	;	8th bit set, 0b 10000000
	mov ecx, 0		;	counter index

	; --- loop through ingredients list ---
	top_loop:
	cmp ecx, 8
	jge end_loop			;	while (ecx < 8) {
		call ask_ingredient	;	ask for next ingredient
		inc ecx				;	ecx++
		jmp top_loop		;	}
	end_loop:

	; --- encrypt order before sending to Spongebob ---
	ror DWORD[order], 13	; try Krabby Patty's side Caesar salad
	not DWORD[order]
	neg DWORD[order]
	mov eax, DWORD[secret]
	xor DWORD[order], eax	; plaintext xor secret = ciphertext

	; --- print final encrypted order code ---
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

	ask_ingredient:
		mov eax, DWORD[ingredients + ecx * 4]
		call print_string
		mov eax, question_colon
		call print_string
		call read_char
		cmp al, 'y'
			jne end_ask	;	anything other than 'y' is read as no
			or DWORD[order], esi
		end_ask:
		call read_char	;	reads \n from last read_char
		shr esi, 1		;	128 -> 64 -> 32 -> ...  -> 2 -> 1
		ret				;	return
