.begin
.org 2048
X:	8
Y:	0
main:
	ld [X], %r1
	add %r1, %r0, %r5 	!Contador cuadrado
	add %r15, %r0, %r16
	call cuadrado
	st %r2, [Y]
	jmpl %r16, 4, %r0
cuadrado:
	addcc %r1, %r2, %r2
	bvs no_representable
	addcc %r5, -1, %r5
	be terminar
	ba cuadrado
terminar:
	jmpl %r15, 4, %r0
no_representable:
	add %r0, -1, %r2
	jmpl %r15, 4, %r0
.end
