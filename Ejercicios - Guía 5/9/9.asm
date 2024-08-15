.begin
.org 2048
X:	-5
Y:	0
.macro push r
	add %r14, -4, %r14
	st r, %r14
.endmacro
.macro pop r
	ld %r14, r
	add %r14, 4, %r14
.endmacro
main:
	ld [X], %r1
	push %r1
	add %r15, %r0, %r16
	call compl_a_2
	pop %r2
	st %r2, [Y]
	jmpl %r16, 4, %r0
compl_a_2:
	pop %r5
	addcc %r5, %r0, %r0
	bneg negar
	push %r5
	jmpl %r15, 4, %r0
negar:
	neg %r5, %r5
	push %r5
	jmpl %r15, 4, %r0
.end

