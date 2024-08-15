.begin
.org 2048
X:	3
Y:	2
Z:	0
main:
	ld [X], %r1
	ld [Y], %r2
	add %r15, %r0, %r16	!Backup call
	call suma
	st %r3, [Z]
	jmpl %r16, 4, %r0
suma:
	addcc %r1, %r2, %r3
	jmpl %r15, 4, %r0
.end

	