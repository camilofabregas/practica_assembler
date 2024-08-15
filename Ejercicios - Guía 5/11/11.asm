.begin
.org 2048
X:	4294967295
Y:	1
Z:	0
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
	ld [Y], %r2
	push %r2
	push %r1
	add %r15, %r0, %r16
	call suma_es_representable
	pop %r3
	st %r3, [Z]
	jmpl %r16, 4, %r0
suma_es_representable:
	pop %r5
	pop %r6
	addcc %r5, %r6, %r7
	bcs no_representable
	add %r0, 0, %r7
	push %r7
	jmpl %r15, 4, %r0
no_representable:
	add %r0, -1, %r7
	push %r7
	jmpl %r15, 4, %r0
.end
