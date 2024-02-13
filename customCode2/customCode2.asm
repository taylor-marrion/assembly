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
	call read_int	; c = edi
	mov edi, eax

	lea esi, [ebx+0x5f]	; esi = a+95

	mov eax, ecx	; eax = b
	shl eax, 0x4	; eax = b * 2^4 = b*16
	cdq
	idiv edi		; eax = (b*16) / c

	imul esi			; [edx:]eax = (a+95) * ((b*16)/c)

	lea esi, [ebx-0x14]	; esi = a-20
	sub eax, esi		; eax - (a-20) = eax + (-a+20)
	; this is not the best way to do this, just wanted to try it
	;sub eax, ebx		; eax -= a
	;add eax, 0x14		; eax -= 20

	call print_int	; output(x)
	call print_nl	;

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
