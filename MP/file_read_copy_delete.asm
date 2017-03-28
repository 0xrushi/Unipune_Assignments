section .data
menu db "1.Copy",10
     db "2.Type",10
     db "3.Delete",10
     db "4.Exit",10

	mlen equ $-menu
	msg1 db "File Deleted !",10
	msg1len equ $-msg1
	msg2 db "Error!",10
	msg2len equ $-msg2
	msg3 db "File Copied Successfully !",10
	msg3len equ $-msg3

section .bss
	filename1 resb 30
	filename2 resb 30
	filehandle1 resq 1
	filehandle2 resq 1
	buff resb 4096
	bufflen equ $-buff
	a_len resb 20
	choice resb 2

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

	%macro fopen 1
	mov  rax,2 
	mov  rdi, %1 
	mov  rsi, 2 
	mov  rdx, 0777o
	syscall 
	%endmacro
	         
	%macro fread 3
	mov  rax,0 
	mov  rdi, %1 
	mov  rsi, %2 
	mov  rdx, %3 
	syscall
	%endmacro

	%macro fwrite 3
	mov rax,1
	mov rdi,%1
	mov rsi,%2
	mov  rdx,%3
	syscall
	%endmacro

	%macro fclose 1
	mov rax,3
	mov rdi,%1
	syscall
	%endmacro

	%macro fdelete 1
	mov rax,87
	mov rdi,%1
	syscall
	%endmacro

section .text
global _start
 _start:
	pop rcx
	pop rsi
	pop rsi
	mov r8,[rsi]
	mov [filename1],r8
	pop rsi
	mov r9,[rsi]
	mov [filename2],r9


spawn:
	print menu,mlen
	read choice,2
	mov al,byte[choice]
	cmp al,'1'
	je copy
	cmp al,'2'
	je type
	cmp al,'3'
	je delete
	cmp al,'4'
	je exit
	jmp spawn

copy:
	fopen filename1
	mov [filehandle1],rax
	fread [filehandle1],buff,bufflen
	mov r9,buff
	mov [a_len],rax
	fclose filename1
	fopen filename2
	mov [filehandle2],rax
	fwrite [filehandle2],r9,[a_len]
	fclose filename2
	print msg3,msg3len
	jmp spawn

type:
	print buff,bufflen
	jmp spawn

delete:
	fdelete filename2
	print msg2,msg2len
	jmp spawn

exit:
	mov rax,60
	mov rdi,0
	syscall

