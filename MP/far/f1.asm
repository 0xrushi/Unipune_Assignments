
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


Extern far_proc

global filename,filehandle,buf,abuf,char

section .data



filemsg db "Enter file name "
filemsglen equ $-filemsg

charmsh db "Enter char to search "
charl equ $-charmsh

errmsg db "error in opening file "
errmsglen equ $-errmsg

section .bss
buf resb 4096
buflen equ $-buf

abuf resq 1

filename resb 50
filehandle resq 1
char resb 2

section .text

global _start

_start:

    print filemsg,filemsglen
    read filename,50
    dec rax
    mov byte[filename+rax],0

    fopen filename
    
    cmp rax,-1H
    jle error
   
    mov [filehandle],rax

    print charmsh,charl
    read char,2
     
    fread	[filehandle],buf, buflen
   
    mov [abuf],rax
     
    call	far_proc
    jmp	exit

error:
    print errmsg, errmsglen

exit:
    mov rax,60
    MOV rdi,1
    syscall



