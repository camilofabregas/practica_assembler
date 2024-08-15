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
!push largo
!push direccion
main:
	pop %r1		!Direccion
	pop %r2		!Largo
	add %r0, %r0, %r4	!Contador
	add %r15, %r0, %r16
for:
	addcc %r2, %r0, %r0
	be terminar
	addcc %r2, -4, %r2
	ld %r1, %r2, %r3	!Elem. actual arreglo[direccion+largo]
	call cant_1s_binario
	ba for
cant_1s_binario:
	addcc %r3, %r0, %r0		!Flags
	be terminar_num
	bneg aumentar_contador	!Si es neg (1er bit es 1), aumento contador.
	sll %r3, 1, %r3
	ba cant_1s_binario
aumentar_contador:
	add %r4, 1, %r4
	sll %r3, 1, %r3
	ba cant_1s_binario
terminar_num:
	jmpl %r15, 4, %r0
terminar:
	push %r4
	jmpl %r16, 4, %r0
.end
