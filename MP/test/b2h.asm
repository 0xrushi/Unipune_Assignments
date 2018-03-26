section .data
msg db"enter the bcd no you want to convert:"
msglen equ $-msg
         
blank db"",10
blen equ $-blank

section .bss
	bcdcode resb 05	
	count resb 1
	dispbuff resb 16

	
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
   read bcdcode,6
   mov rbx,10
   mov rdx,0
   mov rax,0
   mov byte[count],5
   mov rsi,bcdcode

   up1:
	   mul rbx
	   sub byte[rsi],30h
	   movsx cx,byte[rsi]
	   add ax,cx
	   inc rsi
	   dec byte[count]
	   jnz up1

	mov rbx,rax
	call display
	print dispbuff,16

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

