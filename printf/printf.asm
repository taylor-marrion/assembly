%include "/usr/local/share/csc314/asm_io.inc"

%define	SYS_read	3
%define	SYS_write	4

%define	STDIN		0
%define	STDOUT		1

segment .data
	str1	db	"Hello world", 10,0
	str2	db	"str3 is '%s', isn't that cool?",10,0
	str3	db	"woot woot",0
	str4	db	"%c is a char, but so is %%, %s again!",10,0

segment .bss


segment .text
	global  asm_main
;	extern printf

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	push str1
	call printf
	add esp, 4
;call print_int
;call print_nl
;mov eax, ebx
;call print_int
;call print_nl

	push str3
	push str2
	call printf
	add esp, 8
;call print_int
;call print_nl
;mov eax, ebx
;call print_int
;call print_nl

	push str3
	push 'A'
	push str4
	call printf
	add esp, 12
;call print_int
;call print_nl
;mov eax, ebx
;call print_int
;call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

printf1:
	push ebp
	mov ebp, esp

	mov esi, 0					;	count how many '%'

	mov ecx, [ebp + 8]			;	copy address of a[0]

	; print character
	top_print:					;	do {

	; check for '%_'
	cmp BYTE[ecx], '%'
	jne end_format
	inc ecx						;	"skip" one '%'
	inc esi						;	count one arg "down" the stack

		;	format %c
;		cmp BYTE[ecx], 'c'
;		jne check_s
;			mov edi, ecx
;			push DWORD[ebp + 8 + esi * 4]
;			call printf
;			add esp, 4
;			lea ecx, [edi + 1]
;		jmp end_format

		check_s:	;	format %s
		cmp BYTE[ecx], 's'		;	check for '%s'
		jne end_format
			mov edi, ecx		;	store memory address
			push DWORD[ebp + 8 + esi * 4]
			call printf
			add esp, 4
			lea ecx, [edi + 1]	;	restore memory address
		jmp end_format

	end_format:
	mov eax, SYS_write			;	// sys calls return value to eax
	mov ebx, STDOUT
	;ecx
	mov edx, 1
	int 0x80					;	printf("%c", a[c]);

	inc ecx						;	c++;
	cmp BYTE[ecx - 1], 0		;	} while (a[c] != '\0');
	jne top_print

	mov esp, ebp
	pop ebp
	ret

;	do {
;		// get %c
;		printf("%c", a[c]);
;		c++;
;	} while (a[c] != '\0');

printf:
	push ebp
	mov ebp, esp

	; local variables
	sub esp, 8
	mov DWORD[ebp - 12], 0		;	
	mov DWORD[ebp - 8], 0		;	format_index = 0;
	mov DWORD[ebp - 4], 0		;	strlen = 0;

	; strlen(str):
	push DWORD[ebp + 8]
	call strlen
	add esp, 4
	mov DWORD[ebp - 4], eax		;	

	; format_index(string, strlen, start_index);
	push DWORD[ebp - 8]
	push DWORD[ebp - 4]
	push DWORD[ebp + 8]
	call find_format
	add esp, 12
	mov DWORD[ebp - 8], eax

	; print by system call
	mov eax, SYS_write
	mov ebx, STDOUT
	mov ecx, [ebp + 8]
	mov edx, DWORD[ebp - 4]
	int 0x80

; testing
mov eax, DWORD[ebp - 4]
mov ebx, DWORD[ebp - 8]

	mov esp, ebp
	pop ebp
	ret

find_format:
	push ebp
	mov ebp, esp

	;	[ebp + 8] = string
	;	[ebp + 12] = starting index

	sub esp, 4
	mov DWORD[ebp - 4], 0	; i=0;

	mov ecx, [ebp + 8]

	top_finder_loop:


	cmp BYTE[ecx], '%'

	end_finder_loop:

	mov eax, DWORD[ebp - 4]	;	eax = index of '%'
	mov esp, ebp
	pop ebp
	ret

strlen:
	push ebp
	mov ebp, esp

	sub esp, 4
	mov DWORD[ebp - 4], 0	;	int i=0;

	top_strlen_loop:
	mov ecx, DWORD[ebp - 4]
	mov ebx, DWORD[ebp + 8]
	cmp BYTE[ebx + ecx], 0
	je end_strlen_loop

	inc DWORD[ebp - 4]
	jmp top_strlen_loop

	end_strlen_loop:

	mov eax, DWORD[ebp - 4]	;	eax = strlen

	mov esp, ebp
	pop ebp
	ret
