%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	nums	dd	0,0,0,0,0,0,0,0,0,0	;	array to hold user ints
	swaps	dd	1	;	counts number of swaps during each pass

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
	; sort ints (bubble sort)

	mov ecx, 0					;	i = 0
	mov esi, 9					;	esi = n - i - 1

	top_outer_loop:
	mov DWORD[swaps], 0			;	reset swaps to 0
	cmp ecx, 9					;	while (i < n-1)
	jge end_outer_loop

		mov edx, 0				;	j = 0
		top_inner_loop:
		cmp edx, esi			;	while (j < n-i-1)
		jge end_inner_loop

			mov eax, DWORD[nums + edx * 4]
			mov ebx, DWORD[nums + edx * 4 + 4]

			cmp eax, ebx		;	if (eax <= ebx) {
			jle end_swap		;	goto end_swap;
								;	} else { //swap
				mov DWORD[nums + edx * 4], ebx
				mov DWORD[nums + edx * 4 + 4], eax
				inc DWORD[swaps]	;	swaps++
								;	}
			end_swap:

		inc edx					;	j++
		jmp top_inner_loop
		end_inner_loop:

	cmp DWORD[swaps], 0			;	if (swaps == 0) { //sorted
	je end_outer_loop			;	break; }

	inc ecx						;	i++
	dec esi						;	esi--
	jmp top_outer_loop
	end_outer_loop:

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
