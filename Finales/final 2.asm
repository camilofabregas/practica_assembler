.begin
.org 2048
.macro push r
	add %r14, -4, %r14
	st r, %r14
.endmacro
.macro pop r
	ld %r14, r
	add %r14, 4, %r14
.endmacro
Y:	0
main:
	add %r15, %r0, %r16
	call signo_numero
	pop %r2
	andcc %r2, %r0, %r0
	be es_negativo
	ba terminar
signo_numero:
	pop %r1
	add %r1, %r0, %r2	!Copia de %r1
	sll %r1, 1, %r2
	srl %r2, 31, %r2	!Será un 1 o un 0.
	push %r2
	jmpl %r15, 4, %r0
es_negativo:
	!Hay que guardar el numero en la direc. C2A00A12Ah.
	!C2A0A12A = 1100 0010 1010 0000 1010 0001 0010 1010
	!22 bits + signif: 11 0000 1010 1000 0010 1000 = 30A828h
	!10 bits - signif: 01 0010 1010 = 12Ah
	sethi 30A828h, %r4
	or %r4, 12Ah, %r4
	st %r1, %r4
terminar:
	st %r2, [Y]
	jmpl %r16, 4, %r0
.end
