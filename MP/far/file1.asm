extern far_procedure
global filehandle,buf,abuf_len,char
section .data
	filemsg db "Enter file name: "
	filemsg_len equ $-filemsg
	errmsg db "Error in File opening.",10
	errmsg_len equ $-errmsg
	charmsg   db "Enter char: "
	charmsg_len equ $-charmsg

section .bss
	filename resb 50
	filehandle resq 1
	buf resb 4096
	buf_len equ $-buf
	abuf_len resq 1
	char resb 2

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
%macro fopen 1
	mov rax,2	;open
	mov rdi,%1	;filename
	mov rsi,2	;mode
	mov rdx,0777o	;permission(octal)
	syscall
%endmacro
%macro fread 3
	mov rax,0	;read
	mov rdi,%1	;filehandle
	mov rsi,%2	;buf
	mov rdx,%3	;buf_len
	syscall
%endmacro
%macro fwrite 3
	mov rax,1	;write/print
	mov rdi,%1	;filehandle
	mov rsi,%2	;buf
	mov rdx,%3	;bbuf_len
	syscall
%endmacro
%macro fclose 1
	mov rax,3	;close
	mov rdi,%1	;filehandle
	syscall
%endmacro

section .code
global _start
_start:
	
	print filemsg,filemsg_len
	read filename,50
	dec rax
	mov byte[filename+rax],0
	print charmsg,charmsg_len
	read char,2
	fopen filename
	cmp rax,-1H	;return -1 if any error
	jle error
	mov [filehandle],rax
	fread [filehandle],buf,buf_len
	mov [abuf_len],rax
	call far_procedure
	jmp exit
	error:
		print errmsg,errmsg_len
	exit:
		mov rax,60
		mov rdi,0
		syscall
