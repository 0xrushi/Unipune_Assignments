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
	msg db '',0xa
	len equ $ - msg
	msg0 db '.',0xa
	len0 equ $ - msg0
	msg1 db 10, 'Calculate Mean, Variance & Standard Deviation.',0xa
	len1 equ $ - msg1
	msg2 db 10, 'The Numbers are ',0xa
	len2 equ $ - msg2
	msg3 db 10, 'Mean: '
	len3 equ $ - msg3
	msg4 db 10, 'Variance: '
	len4 equ $ - msg4
	msg5 db 10, 'Standard Deviation: '
	len5 equ $ - msg5
	count db 03
	c dt 3.0
	a dt 10.2, 4.9, 5.0
	cnt db 0
	th dt 10000.0
	
	%macro display 2
	push rsi
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	pop rsi
	%endmacro
	
section .bss
	diff rest 1
	mean rest 1
	var rest 1
	sd rest 1
	dispbuff resb 1
	dispbuff1 resb 1
section .text
	global _start
_start:

	display msg1, len1
	
	finit				;Initialize the Numeric Co-Processor
	fldz				;Load Stack top with 0
	
;***********************************MEAN***************************************

	mov r9b, byte[count]
	mov rcx, r9
	mov rsi, a
	
stkarr:	fld tword[rsi]			;Load Stack top with rsi
	mov r8, rsi
	add r8, 10
	mov rsi, r8
	loop stkarr
	
	mov cl, byte[count]
	dec cl

addarr:	fadd				;Stack top= ST[1]+ST[0]= (b+c)+a
	loop addarr
	
	fld tword[c]			;Load Stack top with count
	fdiv				;Quotient=ST[1]/ST[0]=Stack top= [(b+c)+a]/count
	fld tword[th]
	fmul
meano:	fstp tword[mean]		;Store & Pop mean in the destination variable

;***********************************VARIANCE************************************
	
	mov rsi, a
	mov cl, byte[count]
	
stkarr1:	
	fld tword[rsi]			;Load Stack top with rsi
	fld tword[mean]			;Load Stack top with mean
	fsub				;Stack top= ST[1]-ST[0]= ai - mean
	fstp tword[diff]		;Store & pop Stack top in a variable
	fld tword[diff]			;Load Stack top with diff
	fld tword[diff]			;Load Stack top with diff
	fmul				;Squaring (ai-mean)
	mov r8, rsi
	add r8, 10
	mov rsi, r8
	loop stkarr1
	
	mov cl, byte[count]
	dec cl

addarr1:
	fadd				;Stack top= ST[1]+ST[0]= [(b-mean)^2 + (c-mean)^2] + (a-mean)^2
	loop addarr1
	
	fld tword[c]			;Load Stack top with count
	fdiv				;ST[1]/ST[0]=Stack top= {[(b-mean)^2+(c-mean)^2]+(a-mean)^2}/count
	fld tword[th]
	fmul
vari:	fstp tword[var]			;Store & pop variance in the destination variable

;*****************************STANDARD DEVIATION********************************
	
	fld tword[var]			;Load Stack top with variance
	fsqrt				;Stack top= sqrt(variance)
sdn:	fstp tword[sd]			;Store & Pop sqrt(variance) in the destination variable
		
;*************************************************************************************************	

	display msg3, len3
	mov ebp, mean
	call disp
	
	mov rax,60
	syscall
	
;SUBROUTINES:

disp:
	mov byte[cnt], 10
	add ebp, 9
	again:
		mov bl, [ebp]
		cmp byte[cnt], 2
		jne next
		display msg0, len0
		jmp skip1
		next:
			mov rcx, 2
			dispup:
				rol bl, 4
				mov [dispbuff], bl
				and bl, 0fh
				cmp bl, 09h
				jbe skip
				add bl, 07h
			skip:
				add bl, 30h
				mov [dispbuff1], bl
				display dispbuff1, 1
				mov bl, [dispbuff]
				loop dispup
	skip1:
		dec ebp
		dec byte[cnt]
		jnz again
	display msg, len
	ret