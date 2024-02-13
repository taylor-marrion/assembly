%include "/usr/local/share/csc314/asm_io.inc"


segment .data


segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	call read_int ; cyber1 = userinput
	mov ebx, eax  ; ebx = cyber1
	call read_int ; cyber2 = userinput
	mov ecx, eax  ; ecx = cyber2

	mov eax, ebx  ; eax: cyber3 = cyber1
	sub eax, ecx  ; cyber3 = cyber1 - cyber2
	add eax, 1337 ; cyber3 += 1337

	add eax, ebx  ; eax: cyber4 = cyber3 + cyber1
	add eax, 9    ; cyber4 + 9

	call print_int ; print (cyber4)

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
