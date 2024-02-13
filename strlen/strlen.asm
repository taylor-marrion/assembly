%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	mystring	db	"catdog",0

	scanffmt	db	"%1023s",0

segment .bss

	buffer	resb	1024

segment .text
	global  asm_main
	extern scanf

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; scanf("%1023s", buffer);
	push buffer
	push scanffmt
	call scanf
	add esp, 8

	; eax = strlen(buffer);
	push buffer
	call strlen
	add esp, 4

	call print_int
	call print_nl

	; strlen(catdog)
	push mystring
	call strlen
	add esp, 4	;	sending 1 parameter to function

	call print_int
	call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

strlen:
	push ebp
	mov ebp, esp

	sub esp, 4	;	reserve space for local variable
	mov DWORD [ebp - 4], 0	;	i=0;

	toploop:
	mov ecx, DWORD[ebp - 4]
	mov ebx, DWORD[ebp + 8]
	cmp BYTE[ebx + ecx], 0	;	cmp to null byte
	je endloop

	inc DWORD[ebp - 4]
	jmp toploop

	endloop:

	mov eax, DWORD[ebp - 4]
	mov esp, ebp
	pop ebp
	ret
