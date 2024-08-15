.begin
.org 2048
X:		-15
Y:		0
mascara:	7FFFFFFFh	!0111...1111 en decimal		 
main:
	ld [X], %r10
	ld [mascara], %r11
	add %r15, %r0, %r16
	call valor_absoluto
	st %r10, [Y]
	jmpl %r16, 4, %r0
valor_absoluto:
	and %r10, %r11, %r10
	jmpl %r15, 4, %r0
.end
