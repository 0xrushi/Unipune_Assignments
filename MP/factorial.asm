section .data
	msg db "Hello",10
	msglen equ $-msg


section .bss
	num resb 4
	cnt resb 4
	result resb 16
	dispbuf resb 16

	%macro read 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

	%macro print 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

section .text
	global _start
	_start:
	pop rcx
	pop rsi
	pop rsi
	mov bx,[rsi]
	sub bx,30h
	mov word[num],bx
	mov byte[cnt],bl
	mov ax,bx
	up:
		push bx
		dec bx
		cmp bx,1h
		jne up
		mov ax,1
	;call facto
	here:
		pop bx
		cmp bx,00
		je down
		mul bx
		jmp here
	;print msg,msglen
	down:
		mov [result],rax
		mov rbx,00
		mov rbx,[result]
		call display
		print dispbuf,16



exit:
	mov rax,60
	mov rdi,0
	syscall

display:
    mov rdi,dispbuf 
    mov rcx,16
up1:
	rol rbx,04 
	mov dl,bl
	and dl,0Fh
	cmp dl,09h
	jg add_37
	add rdx,30h
	jmp next
add_37:
	add rdx,37h
	next mov [rdi],dl
	inc rdi
	dec cx
	jnz up1
	ret

