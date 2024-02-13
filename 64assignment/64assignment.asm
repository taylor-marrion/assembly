
segment .data

	scanf_fmt	db	"%d",0

	printf_max	db	"Largest: %d",10,0
	printf_min	db	"Smallest: %d",10,0
	printf_sum	db	"Sum: %d",10,0

	max_int		dd	0x80000000	;	most neg
	min_int		dd	0x7fffffff	;	most pos
	sum_int		dd	0			;	0

segment .bss

	array	resd	10

segment .text
	global  main
	extern 	scanf
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
		call scanf	;	this returns eax=1

		; scanf clobbers rsi, so esi cannot be used
		; must happen AFTER scanf call
		mov eax, DWORD[array + r15 * 4]

		; compare to max
		cmp eax, DWORD[max_int]
		jle check_min
			mov DWORD[max_int], eax

		; compare to min
		check_min:
		cmp eax, DWORD[min_int]
		jge add_to_sum
			mov DWORD[min_int], eax

		; add to sum
		add_to_sum:
		add DWORD[sum_int], eax

	inc r15
	jmp top_readloop
	end_readloop:

	; printf("%d\n", max_int);
	mov rdi, printf_max
	mov esi, DWORD[max_int]
	call printf

	; printf("%d\n", min_int);
	mov rdi, printf_min
	mov esi, DWORD[min_int]
	call printf

	; printf("%d\n", sum_int);
	mov rdi, printf_sum
	mov esi, DWORD[sum_int]
	call printf

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		rsp, rbp
	pop		rbp
	ret
