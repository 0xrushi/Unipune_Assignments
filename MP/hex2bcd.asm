	section .data
msg db "Enter d Number :",10
msglen equ $-msg

section .bss
num resb 5

count resb 1

ans resw 1
char_ans resb 4

%macro print 02
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
;*********************************************************************************************************************************************
section .code
global _start
_start:

print msg,msglen;
read num,05
call accept
mov ax,bx

mov rdx,00h 		;convert
mov bx,10
back1:
mov rdx,00h
div bx
push dx
inc byte[count]
cmp ax,0h
jne back1

print_bcd1:

pop 	dx		
	add 	dl,30h	
	mov	[char_ans],dl
	print	char_ans,1
	dec 	byte[count]
	jnz 	print_bcd1
;*********************************************************************************************************************************************
exit:
 		mov rax, 60
		mov rbx, 0
		syscall
;*********************************************************************************************************************************************
accept:
		mov ax,00
		mov bx,00
		mov rsi,num
		mov rcx,04
		up:
			rol bx,04
			mov al,[rsi]
			cmp al,39H
			jg next1
			sub al,30H
			jmp next11
			next1:
				sub al,37H
			next11:
				add bl,al
				inc rsi
				dec rcx
				jnz up
	ret
