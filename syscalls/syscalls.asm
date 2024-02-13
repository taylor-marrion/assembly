;%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	mystr	db	"Hello world",10,0

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; sys_getpid
	mov eax, 20		;	sys_getpid
	int 0x80

	; sys_kill (pid : 6)
	mov ebx, eax	;	pid
	mov eax, 37		;	sys_kill
	mov ecx, 6		;	SIGABRT
	int 0x80
	; this should print "Aborted" and exit program

	; print "Hello world"
	mov eax, 4		;	
	mov ebx, 1		;	
	mov ecx, mystr	;	
	mov edx, 12		;	
	int 0x80		;	

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
