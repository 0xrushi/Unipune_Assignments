;ASSIGNMENT NAME:- Calculate Mean, Variance & Standard Deviation of numbers stored in an array using the Numeric Co-processor 80387.

;INPUT:

extern printf

section .data
	msg db '',0xa
	len equ $ - msg
	msg1 db 10, 'Calculate Mean, Variance & Standard Deviation.', 0xa, 0
	len1 equ $ - msg1
	msg2 db 10, 'The Numbers are ', 0
	len2 equ $ - msg2
	msg3 db 10, 'Mean: ', 0
	len3 equ $ - msg3
	msg4 db 10, 'Variance: ', 0
	len4 equ $ - msg4
	msg5 db 10, 'Standard Deviation: ', 0
	len5 equ $ - msg5

	count db 03

	c dq 3.0

	a dq 10.2, 4.9, 5.0

	cnt db 0
	fmt db "%s%lf", 10, 0          ; The printf format, "\n",'0'
	fmt1 db "%s%lf, %lf, %lf", 10, 0          ; The printf format, "\n",'0'
	
%macro display 2
	push rsi
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
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

%macro displayf2 4
	mov rdi,fmt1
	sub rsp,8
	mov rsi,%1
	movsd xmm0,%2
	movsd xmm1,%3
	movsd xmm2,%4
	mov rax,1
	call printf
	add rsp,8
%endmacro 
	
section .bss
	diff resq 1  ;this is same as resb 8
	mean resq 1
	var resq 1
	sd resq 1

section .text
global main
main:

	display msg1, len1
	
	displayf2 fmt1,[a],[a+8],[a+16]
	
	finit				;Initialize the Numeric Co-Processor
	fldz				;Load Stack top with 0
	
;***********************************MEAN***************************************

	mov r9b, byte[count]
	mov rcx, r9
	mov rsi, a
	
stkarr:	fld qword[rsi]			;Load Stack top with rsi
	mov r8, rsi
	add r8, 8
	mov rsi, r8
	loop stkarr
	
	mov cl, byte[count]
	dec cl

addarr:	fadd				;Stack top= ST[1]+ST[0]= (b+c)+a
	loop addarr
	
	fld qword[c]			;Load Stack top with count
	fdiv				;Quotient=ST[1]/ST[0]=Stack top= [(b+c)+a]/count
meano:	fstp qword[mean]		;Store & Pop mean in the destination variable

;***********************************VARIANCE************************************
	
	mov rsi, a
	mov cl, byte[count]
	
stkarr1:	
	fld qword[rsi]			;Load Stack top with rsi
	fld qword[mean]			;Load Stack top with mean
	fsub				;Stack top= ST[1]-ST[0]= ai - mean
	fstp qword[diff]		;Store & pop Stack top in a variable
	fld qword[diff]			;Load Stack top with diff
	fld qword[diff]			;Load Stack top with diff
	fmul				;Squaring (ai-mean)
	mov r8, rsi
	add r8, 8
	mov rsi, r8
	loop stkarr1
	
	mov cl, byte[count]
	dec cl

addarr1:
	fadd				;Stack top= ST[1]+ST[0]= [(b-mean)^2 + (c-mean)^2] + (a-mean)^2
	loop addarr1
	
	fld qword[c]			;Load Stack top with count
	fdiv				;ST[1]/ST[0]=Stack top= {[(b-mean)^2+(c-mean)^2]+(a-mean)^2}/count
vari:	fstp qword[var]			;Store & pop variance in the destination variable

;*****************************STANDARD DEVIATION********************************
	
	fld qword[var]			;Load Stack top with variance
	fsqrt				;Stack top= sqrt(variance)
sdn:	fstp qword[sd]			;Store & Pop sqrt(variance) in the destination variable
		
;*************************************************************************************************	

	displayfloat msg3, mean
	displayfloat msg4, var
	displayfloat msg5, sd
	
	mov rax,60
	syscall

