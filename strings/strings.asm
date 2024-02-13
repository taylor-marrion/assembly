%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	yes_pal_str	db	"Yes, this is a palindrome",10,0
	no_pal_str	db	"No, this is not a palindrome",10,0

segment .bss

	; this is probably enough! as long as user enters <1025 chars
	mystr	resb	1024

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; read string from user
	mov ecx, 0	;	counter index
	readloop:

		call read_char
		mov BYTE[mystr + ecx * 1], al

	inc ecx
	cmp al, 10	;	'\n'
	jne readloop

	; overwrite newline with null byte
	mov BYTE[mystr + ecx * 1 - 1],0

	; --------------------------------
	; find string length
	mov ecx, 0
	countloop:
	cmp BYTE[mystr + ecx * 1], 0
	je endcountloop
	inc ecx
	jmp countloop
	endcountloop:

	mov eax, ecx
	call print_int
	call print_nl

	; --------------------------------
	; print string
	mov eax, mystr
	call print_string
	call print_nl

	; -------------------------------
	; check palindrome
	mov edi, 0			;	index variable
	lea esi, [ecx - 1]	;	last index of string
	shr ecx, 1			;	ecx = ecx / 2

	mov eax, no_pal_str	;	assume not palindrome

	toploop:
	cmp edi, ecx		;	while (edi < ecx)
	jge endloop
		; if (mystr[edi] != mystr[esi])
		cmp BYTE[mystr + edi * 1], BYTE[mystr + esi * 1]
		jne endloop		;	goto endloop
		inc edi			;	edi++
		dec esi			;	esi--
		jmp toploop
	mov eax, yes_pal_str
	endloop:

	call print_string
	call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
