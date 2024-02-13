%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	seats	dd	0,0,0,0,0,0,0,0,0,0,

	seat_reserved_str	db	"Seat reserved, have a great flight!",10,0
	whoops_taken_str	db	"Whoops! That seat is taken.",10,0 ; 10 = ASCII ' '
	whoops_exist_str	db	"Whoops! That seat doesn't exist.",10,0
	all_gone_str		db	"All seats have been rserved!",10,0

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; 10 air plane seats, users can reserve seats at index 0-9

	mov esi, 0	;	seats reserved
	top_loop1:

		mov edi, 0	; index variable
		top_loop2:	;	print array
		cmp edi, 10	;	if (edi < 10)
		jge end_loop2

			mov eax, DWORD[seats + edi * 4]
			call print_int
			mov al, ' '
			call print_char

		inc edi
		jmp top_loop2
		end_loop2:

	call print_nl

	call read_int

	cmp eax, 0
		jl whoops_exist
	cmp eax, 9
		jg whoops_exist

	cmp DWORD[seats + eax * 4], 1
		je whoops_taken
	mov DWORD[seats + eax * 4], 1	;	reserve seat
		mov eax, seat_reserved_str
		call print_string
	inc esi			; esi++
	jmp no_error

	whoops_exist:
		mov eax, whoops_exist_str
		call print_string
		jmp no_error

	whoops_taken:
		mov eax, whoops_taken_str
		call print_string
		jmp no_error

	no_error:
	cmp esi, 10		;	if (seats_reserved < 10)
	jl top_loop1	;	

	mov eax, all_gone_str	; all seats reserved
	call print_string

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
