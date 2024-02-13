%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	format	db	"Hamming distance = %d",10,0

	; the hamming distance between these is 1
	str1	db	"text",0
	str2	db	"test",0

segment .bss


segment .text
	global  asm_main
	extern	printf

asm_main:
	push	ebp
	mov		ebp, esp
	;***************CODE STARTS HERE***************************

	; call your ham dist function here
	; pass str1 and str2 as arguments
	; result gets returned in EAX

	; eax = hamdist(str1, str2);
	push str2
	push str1
	call hamdist
	add esp, 8	;	2 arguments to function

	push	eax		; the returned integer from hamdist()
	push	format	; "Hamming distance = %d\n"
	call	printf
	add		esp, 8

	;***************CODE ENDS HERE*****************************
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

hamdist:
	push ebp
	mov ebp, esp
	sub esp, 8	;	reserve space for two local variables

	mov DWORD [ebp - 4], 0			;	unmatched=0;
	mov DWORD [ebp - 8], 0			;	c=0;

	toploop:
	mov eax, DWORD[ebp + 8]			;	eax = str1
	mov ebx, DWORD[ebp + 12]		;	ebx = str2
	mov ecx, DWORD[ebp - 8]			;	ecx = c
	cmp BYTE[eax + ecx], 0			;	while a[c] != '\0' {
	je endloop

		mov al, BYTE[eax + ecx]		;		al = a[c]
		mov bl, BYTE[ebx + ecx]		;		bl = b[c]
		cmp al, bl					;		if (a[c] != b[c]) {
		je end_cmp
			inc DWORD[ebp - 4]		;			unmatched ++;
		end_cmp:					;		}
	inc DWORD[ebp - 8]				;		c++;
	jmp toploop						;	}
	endloop:

	mov eax, DWORD[ebp - 4]			;	eax = unmatched;
	mov esp, ebp
	pop ebp
	ret
