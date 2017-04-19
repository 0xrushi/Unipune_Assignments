section .data
%macro print 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro read 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro


section .bss
	res resb 16
	num resb 4
	dispbuff resb 16

section .text
global _start
_start:
	pop rcx
	pop rsi
	pop rsi
	mov bx,[rsi]
	sub bx,30h
	mov word[num],bx

	mov ax,bx
up2:
	push bx
	dec bx
	cmp bx,1h
	jne up2

	mov ax,1

stackpop:
	pop bx
	cmp bx,00
	je down
	mul bx
	jmp stackpop
down:
	mov [res],rax
	mov rbx,00
	mov rbx,[res]
	call display
	print dispbuff,16

exit:
	mov rax,60
	syscall

display:
    mov rdi,dispbuff
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