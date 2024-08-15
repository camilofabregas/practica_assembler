.begin
.org 2048
X:	4294967295
Y:	0
.macro push r
	add %r14, -4, %r14
	st r, %r14
.endmacro
.macro pop r
	ld %r14, r
	add %r14, 4, %r14
.endmacro
main:
	ld [X], %r1
	add %r2, %r0, %r2	!Contador
	push %r1
	add %r15, %r0, %r16
	call cant_1s_binario
	pop %r2
	st %r2, [Y]
	jmpl %r16, 4, %r0
cant_1s_binario:
	addcc %r1, %r0, %r0	!Flags
	be terminar
	bneg aumentar		!Si es neg (1er bit es 1), aumento contador.
	sll %r1, 1, %r1
	ba cant_1s_binario
aumentar:
	add %r2, 1, %r2
	sll %r1, 1, %r1
	ba cant_1s_binario
terminar:
	push %r2
	jmpl %r15, 4, %r0
.end

!Hay que ir moviendo el numero bit a bit y chequear si es 1 o 0.
!Para eso mover el numero a izq y ver si el num es negativo.
