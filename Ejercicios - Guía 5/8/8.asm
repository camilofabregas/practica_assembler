.begin
.org 2048
X:	2
Y:	3
Z:	0
.macro suma a, b, c
	addcc a, b, c
.endmacro
main:
	ld [X], %r1
	ld [Y], %r2
	suma %r1, %r2, %r3
	st %r3, [Z]
	jmpl %r15, 4, %r0
.end
