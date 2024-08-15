.begin
.org 2048
X:	2147483647
Y:	2147483647
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
	call multiplicar
	pop %r3
	st %r3, [Z]
	jmpl %r16, 4, %r0
multiplicar:
	pop %r1
	pop %r2
	addcc %r2, %r0, %r6	!Creo el contador
	bneg caso_negativo
loop:
	addcc %r3, %r1, %r3
	bvs no_representable
	addcc %r6, -1, %r6
	be terminar
	ba loop
caso_negativo:
	neg %r6, %r6
	ba loop
terminar:
	addcc %r2, 0, %r2
	bneg terminar_neg
	push %r3
	jmpl %r15, 4, %r0
terminar_neg:
	neg %r3, %r3
	push %r3
	jmpl %r15, 4, %r0
no_representable:
	add %r0, -1, %r3
	push %r3
	jmpl %r15, 4, %r0
.end

