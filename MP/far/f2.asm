
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



global	far_proc

extern	filehandle, buf, abuf,char


section .data
	nline		db	10,10
	nline_len:	equ	$-nline
	
	msgl db "FIle OPen"
	msgll equ $-msgl
	smsg		db	10,"No. of spaces are : "
	smsg_len:	equ	$-smsg

	nmsg		db	10,"No. of lines are : "
	nmsg_len:	equ	$-nmsg

	cmsg		db	10,"No. of character occurances are	: "
	cmsg_len:	equ	$-cmsg

section .bss

    section .bss

	scount	resb	04
	ncount	resb	04
	ccount	resb    04

	ans	resb	04

section .text

global _str

_str:

    far_proc:
	
        xor rax,rax
        xor rbx,rbx
        xor rcx,rcx
        xor rsi,rsi
	
	mov bl,[char]
        mov rsi,buf
	
        mov rcx,[abuf]

	
       again:	mov	al,[rsi]

	cmp	al,20h		;space : 32 (20H)
		jne	case_n
		inc	byte[scount]
		jmp	next

case_n:	cmp	al,0Ah		;newline : 10(0AH)
		jne	case_c
		inc	byte[ncount]
		jmp	next

case_c:	cmp	al,bl			;character
		jne	next
		inc	byte[ccount]

next:		inc	rsi
		dec	rcx			;
		jnz	again


        print smsg,smsg_len
		mov	bx,[scount]
		call	display

		print nmsg,nmsg_len
		mov	bx,[ncount]
		call	display

		print cmsg,cmsg_len
		mov	bx,[ccount]
		call	display

	fclose	[filehandle]
	ret


display:MOV rdi,ans
		MOV rcx,04
up:     rol bx,04

		MOV al,bl
		and al,0FH
		cmp al,09H
		jg add_37H
		add al,30H
		jmp skip1

add_37H:add al,37H
skip1:	MOV [rdi],al
		inc rdi
		dec rcx
		jnz up

		print ans,04
		ret
	
