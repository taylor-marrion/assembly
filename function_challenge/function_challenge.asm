%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	scanf_fmt		db		"%d",0
	printf_fmt1		db		"Winner winner!",10,0
	printf_fmt2		db		"Fail :(",10,0

segment .bss

	input			resd	1

segment .text
	global  asm_main
	extern	printf
	extern	scanf

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	sub		esp, 4

	mov		DWORD [ebp - 4], 0
	loop1:

		push	input
		push	scanf_fmt
		call	scanf
		add		esp, 8

	cmp		DWORD [input], 0
	je		endloop1
	push	DWORD [input]
	inc		DWORD [ebp - 4]
	jmp		loop1
	endloop1:

	push	DWORD [ebp - 4]
	call	check_em
	mov		edi, eax
	mov		eax, 4
	mov		ebx, DWORD [ebp - 4]
	add		ebx, 1
	imul	ebx
	add		esp, ebx

	cmp		edi, 0
	je		fail
		push	printf_fmt1
		call	printf
		add		esp, 4
	jmp		end
	fail:
		push	printf_fmt2
		call	printf
		add		esp, 4
	end:

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

check_em:
	push	ebp
	mov		ebp, esp

	sub		esp, 8

	cmp		DWORD [ebp + 8], 7
	jl		check_em_fail

	cmp		DWORD [ebp + 12], 95
	jne		check_em_fail

	mov		eax, DWORD [ebp + 16]
	cdq
	mov		edi, 3
	idiv	edi
	cmp		edx, 0
	jne		check_em_fail

	mov		DWORD [ebp - 8], 0
	mov		DWORD [ebp - 4], 0
	loop2:
	mov		ebx, DWORD [ebp - 4]
	cmp		ebx, DWORD [ebp + 8]
	jge		endloop2

		mov		ecx, DWORD [ebp + 12 + ebx * 4]

		cmp		ecx, DWORD [ebp + 8 + ebx * 4]
		jle		check_em_fail

		add		DWORD [ebp - 8], ecx

	inc		DWORD [ebp - 4]
	jmp		loop2
	endloop2:

	cmp		DWORD [ebp - 8], 1337
	jne		check_em_fail

	mov		eax, 1
	jmp		check_em_end
	check_em_fail:
	mov		eax, 0
	check_em_end:

	mov		esp, ebp
	pop		ebp
	ret

