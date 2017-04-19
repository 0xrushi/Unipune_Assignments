section .data
%macro Print 2					;macro to print
	mov rax,1				;device address
	mov rdi,1				;device address
	mov rsi,%1				;source message to be printed
	mov rdx,%2				;length of the message
	syscall
	%endm	

%macro Read 2					;macro to read
	mov rax,0				;device address
	mov rdi,0				;device address
	mov rsi,%1				;source message to be readed
	mov rdx,%2				;length of the message
	syscall
	%endm
m1 db 0xa
lenm1 equ $-m1
buflen db 20
file1 db 'data.txt',0
;lenm1 equ $-file

m2 db'   '
lenm2 equ $-m2



msg2 db'  After Sorting the contents of file are:    ',0xa
len2 equ $-msg2	
array1 db 0H,0H,0H,0H,0H,0H,0H,0H,0H,0H

section .bss
dispbuff resb 2
buf resb 30
space resb 1
dispbu resb 16

fhandle resq 1

section .text
global _start
_start:


mov rax,2			;open a file
mov rdi,file1
mov rsi,2
mov rdx,0777o
syscall

b2:
cmp rax,-1d
je ex
mov [fhandle],rax
  

mov r8,fhandle
;call dproc16

push qword[fhandle]
mov rax,0			;read a file
mov rdi,[fhandle]
mov rsi,buf
mov rdx,30
syscall
pop qword[fhandle]

b1:	mov r15,buf

	
	mov r9,00
	mov r8,00
	mov r12,0AH
arr:	mov r14,buf
	mov r15,array1
	add r15,r8
	add r14,r9
	mov rsi,r14
	call accept2					;convert the ascii values from the buffer into hex values
	mov [r15],bl
	add r9,3
	inc r8
	
	dec r12
	jnz arr




	mov rcx,9
oloop:	mov rsi,array1
	mov r10,array1
	add r10,1
	mov rdi,r10

	
	mov al,9
iloop:	
	mov dl,[rsi]
	cmp dl,[rdi]
	jbe nexc

	mov r11b,[rdi]
	mov r12b,[rsi]
	mov [rdi],r12b
	mov [rsi],r11b

nexc:
	inc rsi
	inc rdi
	dec al
	cmp al,00
	jnz iloop

loop oloop

Print m1,lenm1
Print msg2,len2
mov r9,00
mov r10,10
mov r8,00
up0: 	mov r8,array1
	add r8,r9
	mov bl,[r8]
	call dproc
	Print m2,lenm2

	add r9,1
	Print m1,lenm1

	sub r10,1
	cmp r10,00
	jnz up0

		
	
	mov r9,00
mov rcx,0AH
mov r8,00
mov r10,00
u:	mov r11,buf
 	mov r8,array1
	add r8,r9
	mov bl,[r8]
	add r11,r10
	call movc
	add r10,3
	add r9,1
	
	
	loop u
	

	mov byte[space],0aH
mov rcx,[fhandle]
b3:	push qword[fhandle]
	mov rax,1		;write a file
	mov rdi,[fhandle]
	mov rsi,space
	mov rdx,1

	syscall
	pop qword[fhandle]

mov rcx,[fhandle]
	push qword[fhandle]
	mov rax,1		;write a file
	mov rdi,[fhandle]
	mov rsi,buf
	mov rdx,30

	syscall
	pop qword[fhandle]

	
	mov rax,3
	mov rdi,[fhandle]
	syscall

ex:	mov rax,60	;terminate program naturally
	syscall


movc:  	mov rdi,r11			;the procedure to display 2 digits
	push rcx
	mov rcx,00	
	mov rcx,2
up1:	rol bl,4
	mov dl,bl
	and dl,0FH
	add dl,30H
	cmp dl,39H
	jbe skip1
	add dl,07H
skip1:	mov [rdi],dl
	inc rdi
	loop up1
	pop rcx
	ret

dproc:  mov rdi,dispbuff			;the procedure to display 16 digits
	mov rcx,00	
	mov rcx,2
u1:	rol bl,4
	mov dl,bl
	and dl,0FH
	add dl,30H
	cmp dl,39H
	jbe sk1
	add dl,07H
sk1:	mov[rdi],dl
	inc rdi
	loop u1
	Print dispbuff, 2
	ret
	


accept2:  mov dl,00
	mov rcx,02				;to convert ascii to hex
	mov bl,00H
l1:	rol bl,04
	mov dl,[rsi]
	cmp dl,39H
	jg a1
	sub dl,30H
	jmp a11
a1: 	sub dl,37H
a11:	add bl,dl
	
	inc rsi
	loop l1
	ret

dproc16:  mov rdi,dispbu			;the procedure to display 16 digits
	mov rcx,00	
	mov rcx,16
u111:	rol rbx,4
	mov dl,bl
	and dl,0FH
	add dl,30H
	cmp dl,39H
	jbe sk111
	add dl,07H
sk111:	mov[rdi],dl
	inc rdi
	loop u111
	Print dispbu, 16
	ret



;-------------------------------------------------------------------------------------
;output in output file
;------------------------------------------------------------------------------------
