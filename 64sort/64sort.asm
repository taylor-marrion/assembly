
segment .data

	scanf_fmt	db	"%d",0
	printf_fmt	db	"%d",10,0

segment .bss

	array	resd	10

segment .text
	global  main
	extern	scanf
	extern	printf

main:
	push	rbp
	mov		rbp, rsp
	; ********** CODE STARTS HERE **********

	; read 10 ints
	mov r15, 0
	top_readloop:
	cmp r15, 10
	jge end_readloop

		; scanf("%d", &array[i]);
		mov rdi, scanf_fmt
		lea rsi, [array + r15 * 4]
		call scanf

	inc r15
	jmp top_readloop
	end_readloop:

	; sort them
	mov r14, 0
	top_sort1:
	cmp r14, 10
	jge end_sort1

		mov r15, 0
		top_sort2:
		cmp r15, 10
		jge end_sort2

			mov ebx, DWORD[array + r14 * 4]
			mov ecx, DWORD[array + r15 * 4]
			cmp ebx, ecx
			jge dont_swap
				mov DWORD[array + r14 * 4], ecx
				mov DWORD[array + r15 * 4], ebx
			dont_swap:

		inc r15
		jmp	top_sort2
		end_sort2:

	inc r14
	jmp top_sort1
	end_sort1:

	; print 10 ints
	mov r15, 0
	top_printloop:
	cmp r15, 10
	jge end_printloop

		; printf("d\n", array[i]);
		mov rdi, printf_fmt
		mov esi, DWORD [array + r15 * 4]
		call printf

	inc r15
	jmp top_printloop
	end_printloop:

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		rsp, rbp
	pop		rbp
	ret
