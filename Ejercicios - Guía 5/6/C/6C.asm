.begin
.org 2048
elems_suma:	2
		3
		0
main:
	add %r15, %r0, %r16
	call suma
	jmpl %r16, 4, %r0
suma:
	ld [elems_suma], %r1
	ld [elems_suma + 4], %r2
	addcc %r1, %r2, %r3
	st %r3, [elems_suma + 8]
	jmpl %r15, 4, %r0
.end
