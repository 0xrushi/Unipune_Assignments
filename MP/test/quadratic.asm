;------------------------------------------ MACRO DEFININTION---------------------------------------
%macro write 2
	MOV rax,1
	MOV rdi,1
	MOV rsi,%1
	MOV rdx,%2
syscall
%endmacro
;----------------------------------------------------------------------------------------------------
section .bss
	x1 rest 01
	x2 rest 02
	temp resd 01
	disbuff resd 01
;----------------------------------------------------------------------------------------------------
section .data
	msg_new db "",10
	msg_newL equ $-msg_new

	msg_comp db "The Roots are Complex",10
	msg_c equ $-msg_comp


	msg_rootOne db "The First Root is",10
	msg_rootL equ $-msg_rootOne

	msg_rootTwo db "The Second Root is",10
	msg_rootLt equ $-msg_rootTwo

	a1 dd 2.0
	b1 dd 4.0
	c1 dd 2.0
	sq dd 0.0
	four dd 4.0
	bsq dd 0.0
	fourac dd 0.0
	hdec dq 100
	two dd 2.0
	twoa dd 0.0
	minus1 dd -1.0
	minusb dd 0.0
	decimal_pt db '.'
;-------------------------------------------------------------------------------------------------------------------------------------


section .text
global _start
_start:
		finit
		fild dword[b1]
		fmul dword[b1]
		fstp dword[r11]

		fld dword[four]
		fmul dword[a1]
		fmul dword[c1]

		fsub st1,st0
		fsqrt
		fbstp tword[sq]

		fldz
		fld dword[b1]
		fchs
		fbstp tword[minusb]
root1:
		fldz
		fldz
		fld tword[minusb]
		fld tword[sq]
		fadd
		fld tword[a1]
		fld tword[two]
		fdiv st1,st0
		fbstp tword[x1]

root2:	
		fld tword[minusb]
		fld tword[sq]
		fsub
		fld tword[a1]
		fld tword[two]
		fdiv
		fbstp tword[x2]

exit:
	mov rax,60
	syscall


