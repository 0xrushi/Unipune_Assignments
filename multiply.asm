section .data

n db " ",10
nlen equ $-n

msg dq "1.Add by repetetive addition ",10
    dq "2.Add by shift addition ",10
    dq "3.Exit ",10
msglen equ $-msg

colon db " : "
colonlen equ $-colon

section .bss
dispbuff resb 04
num resb 03
num2 resb 03
num1 resb 03
choice resb 03
product resb 04

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

section .text
global _start
_start:

print msg,msglen;
read choice,03
cmp al,31h
je addbyrepeat
cmp al,32h
je addbyshift

addbyrepeat:
read num,03
call accept
mov byte[num1],bl

read num,03
call accept
mov byte[num2],bl
mov ax,00
mov al,byte[num1]
mov bl,byte[num2]

addagain:
add word[product],ax
dec bl
jnz addagain

mov bx,word[product]
call display
print dispbuff,04

exit:mov rax,60
     mov rbx,0
     syscall

addbyshift:
read num,03
call accept
mov byte[num1],bl
read num,03
call accept
mov byte[num2],bl
mov ax,00
mov bl,byte[num1]
mov dl,byte[num2]
mov rcx,16

loopshift:
shl ax,1
rol bx,1
jnc down1
add ax,dx
down1:
dec rcx 
jnz loopshift

mov bx,ax
call display
print dispbuff,04
jmp exit

accept:
mov ax,00
mov bx,00
mov rsi,num ;rsi num chya address la point karel
mov rcx,02
up1:
rol bl,04
mov al,[rsi]
cmp al,39h
jg sub37
sub al,30h
jmp next1

sub37:
sub al,37h
next1:
add bl,al
inc rsi
dec rcx
jnz up1
ret

display:
  mov rdi,dispbuff  ;rdi dispbuff cha address la point karel 
  mov rcx,04
up:
  rol bx,04     ;first digit goes to last
  mov dl,bl
  and dl,0Fh
  cmp dl,09h
  jg add_37
  add rdx,30h
  jmp next
add_37:
 add rdx,37h
 next: mov [rdi],dl
 inc rdi
  dec cx
 jnz up
 ret
