section .data
msg db"enter the hex no you want to convert:"
msglen equ $-msg
         
blank db"",10
blen equ $-blank

section .bss
	hexcode resb 05	
	count resb 1
	dispbuff resb 16
	char_ans resb 1

	
%macro print 02
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro read 02
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

section .text
global _start
_start:
   print msg,msglen
   read hexcode,6
   call accept
   mov ax,bx
   
   mov rdx,00h
   mov bx,10
back1:
	mov rdx,00h
	div bx
	push dx
	inc byte[count]
	cmp rax,00h
	jne back1
myprint:
	pop dx
	add dl,30h
	mov [char_ans],dl
	print char_ans,1
	dec byte[count]
	jnz myprint

	exit :
	mov rax,60
	syscall

display:
push rcx	
mov rdi,dispbuff
mov rcx,16

up:
rol rbx,04
mov al,bl
and al,0Fh
cmp al,09h
jg add_37
add al,30h
jmp next

add_37:add al,37h
next:mov [rdi],al
inc rdi
dec rcx
jnz up
pop rcx
ret

accept:
	mov rax,00
	mov rbx,00
	mov rsi,hexcode
	mov rcx,04
up3:	
	rol bx,04
	mov al,[rsi]
	cmp al,39h
	jg next3
	sub al,30h
next3:
	sub al,37h;
	add bl,al
	inc rsi 
	dec rcx
	jnz up3

	ret
