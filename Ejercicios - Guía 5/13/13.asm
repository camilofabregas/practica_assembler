.begin
.org 2048
X:	1
Y:	0
main:
	ld [X], %r1
	add %r15, %r0, %r16
	add %r1, %r0, %r5	!Cargo X en r5 para chequear rango.
	add %r0, 10, %r6	!Cargo 10 en r6 para chequear rango.
	add %r1, %r0, %r2	!Contador factorial. 
	call chequear_rango
	st %r1, [Y]
	jmpl %r16, 4, %r0
chequear_rango:
	addcc %r5, -1, %r5
	be factorial		!Si X se hizo 0 antes que 10, está en rango. Calculo factorial.
	addcc %r6, -1, %r6
	be fuera_de_rango	!Si 10 se hizo 0 antes que X, está fuera de rango.
	ba chequear_rango	!Loop si no se cumple ninguna de las dos.
factorial:
	addcc %r2, -1, %r2
	be terminar_factorial
	add %r2, %r0, %r6	!Contador multiplicar.
multiplicar:
	add %r1, %r3, %r3
	addcc %r6, -1, %r6
	be terminar_multiplicar
	ba multiplicar
terminar_multiplicar:
	add %r3, %r0, %r1
	add %r0, 0, %r3
	ba factorial
terminar_factorial:
	jmpl %r15, 4, %r0
fuera_de_rango:
	add %r0, -1, %r2
	jmpl %r15, 4, %r0
.end
	
