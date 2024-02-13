%include "/usr/local/share/csc314/asm_io.inc"


segment .data


segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
	; a..c = read_int()
	; x = (a+95) * ((b*16) / c) - a + 20

	call read_int	; a = ebx
	mov ebx, eax
	call read_int	; b = ecx
	mov ecx, eax
	call read_int	; c = esi
	mov esi, eax

	mov eax, 16		; eax = 16
	imul ecx		; (b*16) = edx:eax

	cdq				; unnecessary, but good practice before idiv
	idiv esi		; eax = (b*16) / c
	mov edi, eax	; edi = (b*16) / c

	mov eax, 95		; eax = 95
	add eax, ebx	; eax = a+95

	imul edi		; edx:eax = (a+95) * ((b*16) / c)

	sub eax, ebx	; eax = (a+95)*((b*16)/c) - a
	add eax, 20		; eax = (a+95)*((b*16)/c) - a + 20

	call print_int	; output(x)
	call print_nl	;

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
