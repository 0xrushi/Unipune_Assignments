;
;            _     _      _____   ___ 
;               | |   (_)    / __  \ /   |
; _ __ _   _ ___| |__  _  ___`' / /'/ /| |
;| '__| | | / __| '_ \| |/ __| / / / /_| |
;| |  | |_| \__ \ | | | | (__./ /__\___  |
;|_|   \__,_|___/_| |_|_|\___\_____/   |_/
;                                         
;

section .data
	four dt 4.0
	two dt 2.0
	zero dt 0.0
	a dt 1.0
	b dt 4.0
	c dt 4.0
	msg db '',0xa
	len equ $ - msg
	msg0 db 10, 'For Equation, ax^2 + bx + c = 0, calculate the two roots of x.',0xa
	len0 equ $ - msg0
	msg1 db 'The Value for a is '
	len1 equ $ - msg1
	msg2 db 'The Value for b is '
	len2 equ $ - msg2
	msg3 db 'The Value for c is '
	len3 equ $ - msg3
	msg4 db 10, 'Root1: '
	len4 equ $ - msg4
	msg5 db 10, 'Root2: '
	len5 equ $ - msg5
	msg6 db 10, 'The Given Roots are turning out to be Imaginary.',0xa
	len6 equ $ - msg6
	
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
	
section .bss
	d rest 2
	twoa rest 2
	minusb rest 2
	fourac rest 2
	sq rest 2
	x1 rest 2
	x2 rest 2
	dispbuff rest 1
	
section .text
	global _start
_start:

;**************INPUT BLOCK**************

	display msg0, len0
	display msg, len
	
	display msg1, len1
	display a, 4
	display msg, len
	
	display msg2, len2
	display b, 4
	display msg, len
	
	display msg3, len3
	display c, 4
	display msg, len

;****************************************FORMULA LOGIC*******************************************
	
	finit				;Initialize the Numeric Co-Processor
	fldz				;Load Stack top with 0

	fld tword[b]			;Load Stack top with b
	fchs				;Change the Sign on Stack top
	fstp tword[minusb]		;Store & Pop -b in the destination variable
	
	fld tword[a]			;Load Stack top with a
	fld tword[two]			;Load Stack top with two
	fmul				;Stack top= ST[0]*ST[1]= 2*a
	fstp tword[twoa]		;Store & Pop 2*a in the destination variable
	
	fld tword[b]			;Load Stack top with b
	fld tword[b]			;Load Stack top with b
	fmul				;b2 obtained on Stack top
	fld tword[c]			;Load Stack top with c
	fld tword[a]			;Load Stack top with a
	fmul				;Stack top= a*c
	fld tword[four]			;Load Stack top with 4
	fmul				;Stack top= 4*a*c
	fsub				;Stack top= b2 - 4*a*c
	fsqrt				;Stack top= sqrt(b2 - 4*a*c)
	fstp tword[sq]			;Store & Pop sqrt(b2 - 4*a*c) in the destination variable
	
	mov rcx, 02

compare:	
	cmp rcx, 02
	je root1
	cmp rcx, 01
	je root2
	cmp rcx, 00
	je end
root1:
	fld tword[minusb]		;Load Stack top with minusb
	fld tword[sq]			;Load Stack top with sq
	fadd				;Stack top= ST[0]+ST[1]= -b + sqrt(b2 - 4*a*c)
	fld tword[twoa]			;Load Stack top with twoa
	fdiv				;Quotient=ST[1]/ST[0]=Stack top= [-b + sqrt(b2 - 4*a*c)] / (2*a)
ans1:	fstp tword[x1]			;Store & Pop root1 in the destination variable
	dec rcx
	jmp compare
root2:
	fld tword[minusb]		;Load Stack top with minusb
	fld tword[sq]			;Load Stack top with sq
	fsub				;Stack top= ST[0]-ST[1]= -b - sqrt(b2 - 4*a*c)
	fld tword[twoa]			;Load Stack top with twoa
	fdiv				;Quotient=ST[1]/ST[0]=Stack top= [-b - sqrt(b2 - 4*a*c)] / (2*a)
ans2:	fstp tword[x2]			;Store & Pop root2 in the destination variable
	dec rcx
	jmp compare
end:

;*************************************************************************************************

	display msg4, len4
	;mov rbx, tword[x1]
	call disp
	display msg5, len5	
	;mov rbx, tword[x2]
	call disp
end1:	
	mov rax,60
	syscall
	
;SUBROUTINES:

disp:
	mov rdi, dispbuff
	mov rcx, 10
	dispup:
		rol rbx, 4
		mov rdx, rbx
		and rdx, 000fh
		add rdx, 0030h
		cmp rdx, 0039h
		jbe skip
		add rdx, 0007h
	skip:
		mov qword[rdi], rdx
		inc rdi
		loop dispup
	display dispbuff, 10
	display msg, len
	ret