.begin
.org 2048
!push largo
!push direccion
!Asumo que el stack apunta a una direc valida.
.macro push r
	add %r14, -4, %r14
	st r, %r14
.endmacro
.macro pop r
	ld %r14, r
	add %r14, 4, %r14
.endmacro
main:
	pop %r1	!Direccion
	pop %r2	!Largo (en bytes)
	add %r15, %r0, %r16
	add %r0, %r0, %r8	!Contador.
	add %r0, 1, %r20	!Registro con valor 1 para el contador.
for:
	addcc %r2, %r0, %r0
	be terminar
	addcc %r2, -4, %r2
	ld %r1, %r2, %r3
	push %r3
	call chequear_numero
	pop %r7		!Resultado de la subrutina.
	add %r7, %r8, %r8
	ba for
chequear_numero:
	!Queremos ver si hay dos 1s en la pos. 15 y 31.
	pop %r3
	sra %r3, 16, %r4	!Num izq.
	sll %r3, 16, %r5	!Num der.
	sra %r5, 16, %r5	!Num der.
	andcc %r4, %r5, %r6	!Quiero ver flag neg.
	bneg son_dos_negativos
no_son_dos_negativos:
	push %r0
	jmpl %r15, 4, %r0
son_dos_negativos:
	push %r20
	jmpl %r15, 4, %r0
terminar:
	push %r8
	jmpl %r16, 4, %r0
.end