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

	push str3
	push str2
	call printf
	add esp, 8

	push str3
	push 'A'
	push str4
	call printf
	add esp, 12

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

printf:
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
		cmp BYTE[ecx], 'c'
		jne check_s
			mov edi, ecx
			push DWORD[ebp + 8 + esi * 4]
			call printf
			add esp, 4
			lea ecx, [edi + 1]
		jmp end_format

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
