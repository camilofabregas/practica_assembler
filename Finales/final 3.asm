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
array .dwb 10
largo: 40
main:
	!C6400C2Ah = 1100 0110 0100 0000 0000 1100 0010 1010
	!22 + signif: 11 0001 1001 0000 0000 0011 = 319003h
	!10 - signif:	C2Ah
	sethi 319003h, %r1	!Direccion del periferico.
	or %r1, C2Ah, %r1	!Direccion del periferico.
	add %r15, %r0, %r16
	ld [largo], %r3	!Largo del arreglo.
for:
	addcc %r3, %r0, %r0
	be terminar
	addcc %r3, -4, %r3
	call cargar_valor_periferico
	pop %r4		!Obtengo valor del periferico
	ba verificar_signo
cargar_valor_periferico:
	ld %r1, %r4
	push %r4
	jmpl %r15, 4, %r0
verificar_signo:
	addcc %r4, %r0, %r0
	bneg es_negativo
	ba for
es_negativo:
	st %r4, [array + %r3]
	ba for
terminar:
	jmpl %r16, 4, %r0
.end
