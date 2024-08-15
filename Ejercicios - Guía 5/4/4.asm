.begin
.org 2048
X:	3
Y:	5
main:
	ld [X], %r1	!Cargo X en r1
	ld [Y], %r2	!Cargo Y en r2
	st %r2, [X]	!Piso X con r2
	st %r1, [Y]	!Piso Y con r1
.end
