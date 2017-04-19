section .data
%macro read 2
	mov	rax,0
	mov	rdi,0
    mov	rsi,%1
    mov	rdx,%2
	syscall
%endmacro

%macro print 2
	mov	rax,1
	mov	rdi,1
	mov	rsi,%1
	mov	rdx,%2
	syscall
%endmacro

%macro fopen 1
	mov	rax,2
	mov	rdi,%1
	mov	rsi,2
	mov	rdx,0777o
	syscall
%endmacro

%macro fread 3
	mov	rax,0
    	mov	rdi,%1
	mov	rsi,%2
	mov	rdx,%3
	syscall
%endmacro

%macro fwrite 3
	mov	rax,1
	mov	rdi,%1
	mov	rsi,%2
	mov	rdx,%3
	syscall
%endmacro

%macro fclose 1
	mov	rax,3
	mov	rdi,%1
	syscall
%endmacro


	global far_proc
	Extern filename,filehandle,buf,abuf,char

	m1 db "File is opened  ",10
	l1 equ $-m1

	m2 db "Total characters are  ",10
	l2 equ $-m2

	m3 db "Total spaces are ",10
	l3 equ $-m3

	m4 db "Total lines are ",10
	l4 equ $-m4

section .bss
	scount resb 4
	ncount resb 4
	ccount resb 4
	ans resb 4 

section .text
global _start
_start:

far_proc:
	print m1,l1
	xor rax,rax
	xor rbx,rbx
	xor rcx,rcx
	xor rsi,rsi

	mov bl,[char]
	mov rsi,buf
	mov rcx,[abuf]
again:
	mov al,[rsi]

	cmp al,20h
	jne case_n
	inc byte[scount]
	jmp next

case_n: 
	cmp al,0Ah
	jne case_c
	inc byte[ncount]
	jmp next

case_c:
	cmp al,bl
	jne next
	inc byte[ccount]

next:
	inc rsi
	dec rcx
	jnz again

	    print m3,l3
		mov	bx,[scount]
		call	display

		print m4,l4
		mov	bx,[ncount]
		call	display

		print m2,l2
		mov	bx,[ccount]
		call	display

	fclose	[filehandle]
	ret


display:MOV rdi,ans
		MOV rcx,04
up:     rol bx,04

		MOV al,bl
		and al,0FH
		cmp al,09H
		jg add_37H
		add al,30H
		jmp skip1

add_37H:add al,37H
skip1:	MOV [rdi],al
		inc rdi
		dec rcx
		jnz up

		print ans,04
		ret
	
		fclose [filehandle]
		ret