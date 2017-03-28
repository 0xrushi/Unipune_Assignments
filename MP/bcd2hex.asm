section .data
     msg db"enter the bcd no you want to convert:"
     msglen equ $-msg
       
     blank db"",10
     blen equ $-blank
	


section .bss
	
	hexcode resb 05
	bcdcode resb 05
	ascdigit resb 01
	count resb 01
	asciicode resb 04
	
	
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

   up:
	   mul rbx
	   sub byte[rsi],30h
	   movsx cx,byte[rsi]
	   add ax,cx
	   inc rsi
	   dec byte[count]
	   jnz up
	   
	   mov byte[count],4
	   mov rsi,asciicode
 again:     rol ax,4
	    mov bl,al
	    and bl,0fh
	    cmp bl,9
	    jbe nocorrection2
	    add bl,7
	    nocorrection2:
	    add bl,30h
	    mov byte[rsi],bl
	    inc rsi
	    dec byte[count]
	    jnz again
	    print asciicode,4
	    print blank,blen
	    jmp _start
	    

	


        
  exit:	mov rax,60
	mov rdi,0
	syscall
	
	
