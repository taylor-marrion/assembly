%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	nums	dd	0,0,0,0,0,0,0,0,0,0	;	array to hold user ints
	swaps	dd	0	;	counts number of swaps during each pass

	before_msg		db "Please enter 10 integers:",10,0
	after_msg		db	"Sorted:",10,0

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; welcome message
	mov eax, before_msg
	call print_string

	; -------------------------
	; read 10 ints from user
	mov ecx, 0
	top_read_loop:
	cmp ecx, 10
	jge end_read_loop

		call read_int
		mov DWORD[nums + ecx * 4], eax

	inc ecx
	jmp top_read_loop
	end_read_loop:

	; -------------------------
	; sort ints
	top_bubble_sort:
	mov DWORD[swaps], 0x0000	;	resets swaps to 0

		mov ecx, 0				;	i = 0
		toploop:
		cmp ecx, 9				;	while (i < 9)
		jge endloop				;

			mov eax, DWORD[nums + ecx * 4]		;	eax = nums[i]
			mov ebx, DWORD[nums + ecx * 4 + 4]	;	ebx = nums[i + 1]

			cmp eax, ebx		;	if (eax <= ebx) {
			jle skip_swap		;	goto skip_swap;
								;	} else { swap }
				mov DWORD[nums + ecx * 4], ebx
				mov DWORD[nums + ecx * 4 + 4], eax
				inc DWORD[swaps]	;	swaps++

		skip_swap:
		inc ecx				;	i++
		jmp toploop
		endloop:

	cmp DWORD[swaps], 0		;	if (swaps != 0) {
	jne top_bubble_sort		;	do another pass }

	; -------------------------
	; print sorted ints

	mov eax, after_msg
	call print_string

	mov ecx, 0
	top_print_loop:
	cmp ecx, 10
	jge end_print_loop

		mov eax, DWORD[nums + ecx * 4]
		call print_int
		call print_nl

	inc ecx
	jmp top_print_loop
	end_print_loop:

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
