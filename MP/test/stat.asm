;Write 80387ALP to obtain:
;i) Mean ii) Variance iii) Standard Deviation
;For a given set of data elements defined in data segment. Also display result.


%macro write 2			;macro for display
	mov rax,1 
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro read 2			;macro for input
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro exit 0			;macro for exit
	mov rax,60
	xor rdi,rdi
	syscall
%endmacro


section .data
	array dd 5.00,6.00,7.00,8.00,5.00
	count dw 5
	hdec dq 100
	msg1 db 10,10,"****MENU****",10
	len1 equ $-msg1
	msg2 db "1.Calculate Mean",10
	len2 equ $-msg2
	msg3 db "2.Calculate Variance",10
	len3 equ $-msg3
	msg4 db "3.Calculate Standard Variance",10
	len4 equ $-msg4
	msg5 db "4.Exit",10
	len5 equ $-msg5
	msg6 db 10,"Enter choice:"
	len6 equ $-msg6
	msg7 db 10,"Mean:"
	len7 equ $-msg7
	msg8 db 10,"Variance:"
	len8 equ $-msg8
	msg9 db 10,"Standard Deviation:"
	len9 equ $-msg9
	point db "."
		
section .bss
	choice resb 2
	count resb 2
	mean1 resd 1

section .text
  global _start
  _start:
  finit
  fldz
  
  main:

  	write msg1,len1
  	write msg2,len2
  	write msg3,len3
  	write msg4,len4
  	write msg5,len5
  	write msg6,len6

  	read choice,2
  	mov al,choice
case1:
  	cmp al,'1'
  	jne case2
  	write msg7,len7
  	call mea
  	jmp main
mea:
	mov rsi,array
	mov rcx,byte[count]
loop1:
	fadd tword[rsi]
	add rsi,4
	loop loop1	
	
	fdiv word[count]
	fst dword[mean1]


  disp:
    	mov rdi,temp			;mov dnum address into edi
    	mov rcx,02			;initialize ecx with 2
    	dispup1:
    	    rol bl,4			;rotate bl by 4 bits
            mov dl,bl			;move bl into dl
            and dl,0fh			;and of dl with 0fh
            add dl,30h			;add 30h into dl
            cmp dl,39h			;compare dl with 39h
            jbe dispskip1		;jump if below and equal to dispskip1
            add dl,07h			;add 7h into dl
            dispskip1:
                mov [rdi],dl		;mov dl into dnum
                inc rdi			;increament edi by a byte
            loop dispup1		;loop dispup1 while ecx not zero
            write temp,2		;Display dnum by calling macro
          ret				;return from procedure
          
          