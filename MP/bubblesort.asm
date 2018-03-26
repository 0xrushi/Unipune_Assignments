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

%macro fread 3
	mov rax,0
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
%endmacro

%macro fwrite 3
	mov rax,1
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
%endmacro

%macro fopen 1
	mov rax,2
	mov rdi,%1
	mov rsi,2
	mov rdx,0777o
	syscall
%endmacro

%macro fclose 1
	mov rax,3
	mov rdi,%1
	syscall
%endmacro

section .data
	m1 db "Enter File Name ->"
	l1 equ $-m1
	m2 db "Sorted!"
	l2 db $-m2
	m3 db "File Not Found!"
	l3 equ $-m3

section .bss
	filename resb 50
	filehandle resq 1
	arr resb 20
	buf resb 4096
	alen resb 20
	n resb 1

section .text
global _start
 _start:
	print m1,l1
	read filename,50
	dec rax
	mov byte[filename+rax],0
	fopen filename
	cmp rax,-1h
	jle error
	mov [filehandle],rax
	fread [filehandle],buf,4096
	mov [alen],rax
	call copy
	print arr,[n]



jmp exit
error:
	print m3,l3
exit:
	mov rax,60
	syscall


copy:
	mov rsi,buf
	mov rdi,arr
	mov rcx,[alen]
next:
	mov r8,[rsi]
	mov [rdi],r8
	inc byte[n]
	inc rsi
	inc rsi
	inc rdi
	dec rcx
	dec rcx
	jnz next
	ret