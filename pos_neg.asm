section .data

array dq  1234567890ABCDEFH,7234567890ABCDEFH,8234567890ABCDEFH

posmsg db "positive nos:"
posmsglen equ $-posmsg

negmsg db "negative nos:"
negmsglen equ $-negmsg

poscnt db 0
negcnt db 0

section .bss
dispbuff resb 02

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

  mov rsi,array
  mov rcx,03
  
 again:
  mov rax,[rsi]
  bt rax,63
  jc negative
  inc byte[poscnt]
  jmp skip

 negative:inc byte[negcnt]
 skip:add rsi,8
 dec rcx
 jnz again


print posmsg,posmsglen
mov bl,byte[poscnt]
call display
print dispbuff,02

print negmsg,negmsglen
mov bl,byte[negcnt]
call display
print dispbuff,02
exit:mov rax,60
     mov rbx,0
     syscall

display:
  mov rdi,dispbuff
  mov rcx,02

up:
  rol bl,04
  mov dl,bl
  and dl,0Fh
  cmp dl,09h
  jg add_37
  add dl,30h
  jmp next
add_37:
 add dl,37h
 next mov [rdi],dl
  dec cx
 jnz up
 ret

