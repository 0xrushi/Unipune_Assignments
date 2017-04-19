;ASSIGNMENT NAME:- Calculate the Roots of a Quadratic Equation using the Numeric Co-processor 80387.

;INPUT:

extern	printf		; the C function, to be called

section .data
	four dq 4.0
	two dq 2.0
	zero dq 0.0
	a dq 1.0
	b dq 6.0
	c dq 4.0
	msg db '',0xa
	len equ $ - msg
	msg0 db 10, 'For Equation, ax^2 + bx + c = 0, calculate the two roots of x.',0xa, 0
	len0 equ $ - msg0
	msg1 db 'The Value for a is ', 0
	len1 equ $ - msg1
	msg2 db 'The Value for b is ', 0
	len2 equ $ - msg2
	msg3 db 'The Value for c is ', 0
	len3 equ $ - msg3
	msg4 db 10, 'Root1: ', 0
	len4 equ $ - msg4
	msg5 db 10, 'Root2: ', 0
	len5 equ $ - msg5
	msg6 db 10, 'The Given Roots are turning out to be Imaginary.',0xa, 0
	len6 equ $ - msg6
	fmt db "%s%lf", 10, 0          ; The printf format, "\n",'0'
	
	%macro display 2
	push rsi
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	pop rsi
	%endmacro
	
	%macro input 2
	push rsi
	mov rax, 0
	mov rdi, 0
	mov rsi, %1
	mov rdx, %2
	syscall
	pop rsi
	%endmacro
	
	%macro displayfloat 2
	mov rdi, fmt
	sub rsp, 8
	mov rsi, %1
	movsd xmm0, [%2]
	mov rax, 1
	call printf
	add rsp, 8
	%endmacro
	
section .bss
	d resq 2
	twoa resq 2
	minusb resq 2
	fourac resq 2
	sq resq 2
	temp resq 2
	x1 resq 2
	x2 resq 2
	
section .text
	global main
main:

	display msg0, len0
	display msg, len
	
	displayfloat msg1, a
	displayfloat msg2, b
	displayfloat msg3, c
	
;****************************************FORMULA LOGIC*******************************************
	
	finit				;Initialize the Numeric Co-Processor
	fldz				;Load Stack top with 0

	fld qword[b]			;Load Stack top with b
	fchs				;Change the Sign on Stack top
	fstp qword[minusb]		;Store & Pop -b in the destination variable
	
	fld qword[a]			;Load Stack top with a
	fld qword[two]			;Load Stack top with two
	fmul				;Stack top= ST[0]*ST[1]= 2*a
	fstp qword[twoa]		;Store & Pop 2*a in the destination variable
	
	fld qword[b]			;Load Stack top with b
	fld qword[b]			;Load Stack top with b
	fmul				;b2 obtained on Stack top
	fld qword[c]			;Load Stack top with c
	fld qword[a]			;Load Stack top with a
	fmul				;Stack top= a*c
	fld qword[four]			;Load Stack top with 4
	fmul				;Stack top= 4*a*c
	fsub				;Stack top= b2 - 4*a*c
	fstp qword[temp]
	btr qword[temp], 63
	jc endl
	
	fld qword[temp]			;Stack top= b2 - 4*a*c
	fsqrt				;Stack top= sqrt(b2 - 4*a*c)
	fstp qword[sq]			;Store & Pop sqrt(b2 - 4*a*c) in the destination variable
	
	mov rcx, 02

compare:	
	cmp rcx, 02
	je root1
	cmp rcx, 01
	je root2
	cmp rcx, 00
	je end
root1:
	fld qword[minusb]		;Load Stack top with minusb
	fld qword[sq]			;Load Stack top with sq
	fadd				;Stack top= ST[0]+ST[1]= -b + sqrt(b2 - 4*a*c)
	fld qword[twoa]			;Load Stack top with twoa
	fdiv				;Quotient=ST[1]/ST[0]=Stack top= [-b + sqrt(b2 - 4*a*c)] / (2*a)
ans1:	fstp qword[x1]			;Store & Pop root1 in the destination variable
	dec rcx
	jmp compare
root2:
	fld qword[minusb]		;Load Stack top with minusb
	fld qword[sq]			;Load Stack top with sq
	fsub				;Stack top= ST[0]-ST[1]= -b - sqrt(b2 - 4*a*c)
	fld qword[twoa]			;Load Stack top with twoa
	fdiv				;Quotient=ST[1]/ST[0]=Stack top= [-b - sqrt(b2 - 4*a*c)] / (2*a)
ans2:	fstp qword[x2]			;Store & Pop root2 in the destination variable
	dec rcx
	jmp compare
end:

;*************************************************************************************************

	displayfloat msg4, x1
	displayfloat msg5, x2

	jmp end1
endl:
	display msg6, len6
end1:	
	mov rax,60
	syscall

