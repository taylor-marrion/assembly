%include "/usr/local/share/csc314/asm_io.inc"


segment .data


segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	call read_int	; eax
	mov ebx, eax	;
	call read_char

	call read_char	; al
	mov cl, al		;

	mov esi, 0
	toploop1:
	cmp esi, ebx	; if esi < ebx
	jge endloop1	;

		; inner for loop
		mov edi, 0
		toploop2:
		cmp edi, ebx
		jge endloop2

			; if (x==0 || y==0 || x==(size-1) || y==(size-1)) {
			mov edx, ebx
			sub edx, 1

			cmp edi, 0
			je pchar
			cmp esi, 0
			je pchar
			cmp edi, edx
			je pchar
			; do something
			pchar:
			mov al, cl
			call print_char
			jmp ifend
			; } else {
			pspace:
			mov al, ' '
			call print_char
			jmp ifend
			; }

			ifend:

		inc edi
		jmp toploop2

		endloop2:

		call print_nl

	inc esi
	jmp toploop1

	endloop1:

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
