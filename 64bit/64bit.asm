
segment .data

	fmtstr	db	"Hello world %d %d %d %d %d %d",10,0

segment .bss


segment .text
	global  main
	extern	printf

main:
	push	rbp
	mov		rbp, rsp
	; ********** CODE STARTS HERE **********

	; printf("Hello world\n");
	mov rdi, fmtstr
	mov rsi, 10
	mov rdx, 20
	mov rcx, 30
	mov r8, 40
	mov r9, 50
	sub rsp, 8
	push 60
	call printf
	add rsp, 16

	; *********** CODE ENDS HERE ***********
	mov		eax, 0	;	return 0
	mov		rsp, rbp
	pop		rbp
	ret
