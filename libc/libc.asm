%include "/usr/local/share/csc314/asm_io.inc"

%define	SYS_read	3
%define	SYS_write	4

%define	STDIN		0
%define	STDOUT		1

segment .data

	mystr	db	"Dogs are awesome",0

segment .bss

	buff	resb	1024

segment .text
	global  asm_main
;	extern putchar
;	extern getchar
;	extern puts
;	extern gets

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

;	call getchar	;	al

;;	push 'A'		;	0x00000041	;	41 00 00 00
;	push eax
;	call putchar
;	add esp, 4

;	call print_nl

	push buff
	call gets
	add esp, 4

;;	push mystr
	push buff
	call puts
	add esp, 4

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

getchar:
	push ebp
	mov ebp, esp

	sub esp, 4	;	local variable

	mov eax, SYS_read
	mov ebx, STDIN
	lea ecx, [ebp - 4]	;	tells us where to look for char
	mov edx, 1
	int 0x80

	mov al, BYTE[ebp - 4]	;	loads char to print
	mov esp, ebp
	pop ebp
	ret

putchar:
	push ebp
	mov ebp, esp

	mov eax, SYS_write
	mov ebx, STDOUT				;
;	mov ecx, 	;	pointer
	lea ecx, [ebp + 8]		;	load address, not value
	mov edx, 1				;	length of char array
	int 0x80

	mov esp, ebp
	pop ebp
	ret

gets:
	push ebp
	mov ebp, esp

	mov ecx, DWORD[ebp + 8]
	top_get_loop:

		mov eax, SYS_read
		mov ebx, STDIN
		; ecx already done
		mov edx, 1
		int 0x80

	inc ecx
	cmp BYTE[ecx - 1], 10	;	cmp to '\n'
	jne top_get_loop

	mov BYTE[ecx - 1], 0

	mov esp, ebp
	pop ebp
	ret

puts:	;	find length, then make single system call
	push ebp,
	mov ebp, esp

	sub esp, 4

	mov edx, 0	;	edx = string length
	mov ecx, DWORD[ebp + 8]
	toploop:
	cmp BYTE[ecx + edx], 0
	je endloop
	inc edx
	jmp toploop
	endloop:

	mov eax, SYS_write
	mov ebx, STDOUT
	; ecx and edx already set
	int 0x80

	; print newline
	push 10	;	\n
	call putchar
	add esp, 4

	mov esp, ebp
	pop ebp
	ret
