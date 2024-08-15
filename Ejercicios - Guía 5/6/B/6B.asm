.begin
.org 2048
X:	3
Y:	2
Z:	0
.macro push r
	add %r14, -4, %r14	!Habilito lugar en el stack
	st r, %r14		!Guardo dato en el stack
.endmacro
.macro pop r
	ld %r14, r		!Cargo dato del stack en registro.
	add %r14, 4, %r14	!Actualizo stack
.endmacro
main:
	ld [X], %r1
	ld [Y], %r2
	push %r2
	push %r1
	add %r15, %r0, %r16
	call suma
	pop %r3
	st %r3, [Z]
	jmpl %r16, 4, %r0
suma:
	pop %r5
	pop %r6
	addcc %r5, %r6, %r7
	push %r7
	jmpl %r15, 4, %r0
.end
