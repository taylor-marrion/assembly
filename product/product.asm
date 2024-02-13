%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	fmt1	db	"The product is %d",10,0

segment .bss


segment .text
	global  asm_main
	extern	printf

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; product(3,10,5,7);
	push 7
	push 5
	push 10
	push 3
	call product
	add esp, 16

	push eax
	push fmt1
	call printf
	add esp, 8

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

product:
	push ebp
	mov ebp, esp

	sub esp, 8	;	2 local variables

	mov DWORD[ebp - 4], 1	;	p=1
	mov DWORD[ebp - 8], 0	;	i=0

	toploop:
	mov ecx, DWORD[ebp - 8]
	cmp ecx, DWORD[ebp + 8]	;	i<count
	jge endloop

		mov eax, DWORD[ebp - 4]
		imul DWORD[ebp + ecx * 4 + 12]
		mov DWORD[ebp - 4], eax

	inc DWORD[ebp - 8]
	jmp toploop
	endloop:

	mov eax, DWORD[ebp - 4]
	mov esp, ebp
	pop ebp
	ret
