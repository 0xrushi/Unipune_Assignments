section .data
l db "----------",10
ll equ $-l

array dq 1111111111111111h,2222222222222222h,3333333333333333h,4444444444444444h,5555555555555555h
array1 dq 0000000000000000h,0000000000000000h,0000000000000000h,0000000000000000h,0000000000000000h

address dq "Address"
alen equ $-address

Array dq "Array"
Alen equ $-Array

menu dq "Menu :",10
     dq "1.Copy Source Array to Destination Array (Without String Instruction).",10
     dq "2.Overlapping Source Array to Destination Array (Without String Instruction).",10
     dq "3.Exit.",10
menulen equ $-menu

space1 dq "	"
space1len equ $-space1
space2 dq "		"
space2len equ $-space2
space3 dq "			"
space3len equ $-space3

arrcnt db 5
arrcnt1 db 5

newline db "",10
newlen equ $-newline

colon db ':'
clen equ $-colon

smsg db "Source Array "
slen equ $-smsg

dmsg db "Destination Array "
dlen equ $-dmsg

section .bss
dispbuff resb 16
choice resb 2

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

section .code
global _start
_start:
respawn:
print menu,menulen
read choice,2
mov al,byte[choice]
cmp al,'1'
je copy
cmp al,'2'
je overlap
cmp al,'3'
je exit
jmp respawn

;******************************************************************************************************************
copy:
call sdisp
;-----------------------Copying Source Arr to Destination Arr --------------------	
	mov rsi,array	;pointing source index to source array
	mov rcx,05		;setting count equal to 5
	mov rdi,array1	;pointing destination index to destination array

	destination:	;copying source array to destination array
	MOVSQ
	loop destination
call ddisp
jmp respawn


;-----------------------Overlapping Source Arr to Destination Arr --------------------	
overlap:
call sdisp
	mov rsi,array	;pointing source index to source array
	mov rcx,05		;setting count equal to 5
	mov rdi,array1	;pointing destination index to destination array

	destination3:	;copying source array to destination array
	MOVSQ
	loop destination3

	mov rsi,array	;pointing source index to source array
	mov rcx,02		;setting count equal to 2
	mov rdi,array1	;pointing destination index to destination array

	destination2:	;overlapping source array to destination array
	mov rax,[rsi]
	mov [rdi+24],rax
	add rsi,8
	add rdi,8
	loop destination2

call ddisp
jmp respawn

;*****************************************************************************************************************

exit:mov rax,60
     mov rbx,0
     syscall

;*****************************************************************************************************************

sdisp:
;-------------------------- Printing Source Array --------------------------
print smsg,slen
print colon,clen
print newline,newlen
print space1,space1len
print address,alen
print space3,space3len
print Array,Alen
print newline,newlen

mov rsi,array

again:

mov rbx,rsi
mov r8,rsi
call display
print space1,space1len
print dispbuff,16
mov rsi,r8

mov rbx,[rsi]
mov r8,rsi
call display
print space2,space2len
print dispbuff,16
print newline,newlen
mov rsi,r8
add rsi,8
dec byte[arrcnt]
jnz again
ret

ddisp:
;--------------------------Printing destination Array --------------------------
print dmsg,dlen
print colon,clen
print newline,newlen
print space1,space1len
print address,alen
print space3,space3len
print Array,Alen
print newline,newlen

mov rsi,array1

again1:
mov rbx,rsi
mov r8,rsi
call display
print space1,space1len
print dispbuff,16
mov rsi,r8
mov rbx,[rsi]
mov r8,rsi
call display
print space2,space2len
print dispbuff,16
print newline,newlen
mov rsi,r8
add rsi,8
dec byte[arrcnt1]
jnz again1
ret
;-------------------------------------Display---------------------------------------
display:
push rcx	
mov rdi,dispbuff
mov rcx,16

up:
rol rbx,04
mov dl,bl
and dl,0Fh
cmp dl,09h
jg add_37
add dl,30h
jmp next

add_37:add dl,37h
next:mov [rdi],dl
inc rdi
dec rcx
jnz up
pop rcx
ret