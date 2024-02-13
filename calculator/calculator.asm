%include "/usr/local/share/csc314/asm_io.inc"


segment .data

	invalidOp	db	"Invalid operation",10,0
	unknownOp	db	"Unknown operator",10,0

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********

	; simple calculator
	; checks for division by zero and unknown operators
	; does not validate integerss provided by user

	call read_int	;	eax
	mov esi, eax	;	first int

	call read_char	;	needed for proper readng of next char
	call read_char	;	al
	mov bl, al		;	operator

	call read_int	;	eax
	mov edi, eax	;	second int

	mov al, 61		;	mov ASCII "=" into al
	;mov al, 0x3d	;	mov HEX "=" into al
	call print_char	;	print "="
	call print_nl

	; determine operator	;	compare to ASCII
	cmp bl, 43				;	"+"
		je addition
	cmp bl, 45				;	"-"
		je subtraction
	cmp bl, 42				;	"*"
		je multiplication
	cmp bl, 47				;	"/"
		je division
	cmp bl, 37				;	"%"
		je division
	cmp bl, 94				;	"^"
		je exponentiation
	jmp unknownOperator	;	else goto unknownOperator

	; operations
	addition:
		lea eax, [esi + edi]	;	eax <= (esi + edi)
		jmp result

	subtraction:
		mov eax, esi	;	eax <= esi
		sub eax, edi	;	eax = esi - edi
		jmp result

	multiplication:
		mov eax, esi	;	eax <= esi
		imul edi		;	[edx:]eax = esi * edi
		jmp result

	division:
		cmp edi, 0		;	divide by zero
			je invalidOperation
		mov eax, esi	;	eax <= esi
		cdq				; esi => [edx:]eax
		idiv edi		; eax = esi / edi
		; check for modulo
		cmp bl, 37
			je modulo
		jmp result

	modulo:
		mov eax, edx		;	eax <= edx
		jmp result

	exponentiation:			; can not handle negative exponents
		cmp edi, 0
			jl invalidOperation
		mov eax, 1			;	eax = 1
		mov ebx, 0			;	counter variable
		toploop:
			cmp ebx, edi	;	while (ebx < edi) {
			jge endloop
				;
				imul esi	;	eax = (eax * esi)
				inc ebx		;	ebx++
			jmp toploop		;	}
		endloop:
		jmp result

	; print result or error
	result:
	call print_int
	call print_nl
	jmp end

	invalidOperation:
	mov eax, invalidOp
	call print_string
	call print_nl
	jmp end

	unknownOperator:
	mov eax, unknownOp
	call print_string
	call print_nl
	jmp end

	end:

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
