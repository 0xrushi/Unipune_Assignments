global far_procedure
extern filename,buf,abuf_len,char
section .data
	charmsg db "Number of character occurences are: "
	charmsg_len equ $-charmsg
	nlinemsg db "Number of lines are: "
	nlinemsg_len equ $-nlinemsg
	spacemsg db "Number of spaces are: "
	spacemsg_len equ $-spacemsg 
section .bss
	scount resq 1
	ncount resq 1
	ccount resq 1
	char_ans resb 16

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

section .text
global _main
_main:

	far_procedure:
			xor rax,rax
			xor rbx,rbx
			xor rcx,rcx
			xor rsi,rsi
			mov bl,[char]
			mov rsi,buf
			mov rcx,[abuf_len]
			again:
				mov al,[rsi]
				
			case_s:
				cmp al,20H	;space
				jne case_n
				inc qword[scount]
				jmp next
			case_n:
				cmp al,0AH	;new_line
				jne case_c
				inc qword[ncount]
				jmp next
			case_c:
				cmp al,bl
				jne next
				inc qword[ccount]
			next:
				inc rsi
				dec rcx
				jnz again
			print spacemsg,spacemsg_len
			mov rax,[scount]
			call display
			print nlinemsg,nlinemsg_len
			mov rax,[ncount]
			call display
			print charmsg,charmsg_len
			mov rax,[ccount]
			call display
	ret
	display:
		mov rsi,char_ans+3
		mov rcx,4
		cnt:
			mov rdx,0
			mov rbx,10
			div rbx
			add dl,30H
			mov [rsi],dl
			dec rsi
			dec rcx
			jnz cnt
			print char_ans,4
	ret
			
