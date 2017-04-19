%macro read 02
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall 
%endmacro

%macro print 02
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro fopen 1
	mov rax,2
	mov rdi,%1	
	mov rsi,2
	mov rdx,0777o
	syscall
%endmacro

%macro fread 03
	mov rax,0
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
%endmacro

%macro fwrite 03
	mov rax,1
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
%endmacro

%macro fclose 01
	mov rax,3
	mov rdi,%1
	syscall
%endmacro

section .data
	m1 db "Enter file name ",10
	l1 equ $- m1

section .bss	
	filename resb 20
	dispbuff resb 20
	abuf_len resb 50
	filehandle resb 1
	tbuff resb 4096
	tbuffl equ $-tbuff
	array resb 20
	cnt resb 1
	i resb 1
	j resb 1

section .text
global _start
_start:
	print m1,l1
	read filename,20
	dec rax
	mov byte[filename+rax],0

	fopen filename
	mov [filehandle],rax
	fread [filehandle],tbuff,tbuffl
	mov [abuf_len],rax
	fclose filename

	mov byte[cnt],0
	mov rcx,[abuf_len]
	mov rsi,tbuff
	mov rdi,array
removeenter:
	mov r9,[rsi]
	mov [rdi],r9
	inc rsi
	inc rsi
	inc rdi
	inc byte[cnt]
	dec rcx
	dec rcx
	jnz removeenter

mov rbx,[array]
call display
print dispbuff,16

sort:
	mov rbp,[cnt]					;take count in rbp use as n i.e.number of elements
	mov rcx,0						;use rcx as i i.e. index of outer loop 
	dec rbp
up4:								;continue outer loop till i becomes n(outer loop)
	mov rbx,0						;use rbx as j i.e. index of inner loop
	mov rsi,array
up3:								;continue inner loop till j becomes n(inner loop)
	mov rdi,rsi
	inc rdi

	mov al,[rsi]
	cmp al,[rdi]
	jle next2

	mov dl,[rdi]
	mov [rdi],al
	mov [rsi],dl


next2:
	inc rsi
	inc rbx
	cmp rbx,rbp
	jl up3							;(inner loop)

	inc rcx
	cmp rcx,rbp
	jle up4		

belowswap:
	mov rbx,[array]
	call display
	print dispbuff,16	

exit:
	mov rax,60
	syscall


display:
    mov rdi,dispbuff
    mov rcx,20
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