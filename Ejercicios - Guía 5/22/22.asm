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
!direccion:	B0101002h
largo:	32
!	%r1 para almacenar la direccion del vector
!	%r2 para guardar el largo del vector
!	%r3 como copia del largo del vector
!	%r16 como copia de la direccion de llamado a esta subrutina
!	%r4 para guardar la lectura del vector
!	%r5 para guardar el maximo/minimo
main:	
	sethi 0x2C0404, %r1	
	or %r1, 0x2, %r1	!Direccion	
	ld [largo], %r2	!Largo
	push %r1
	push %r2
	addcc %r2, -4, %r2	!Deja el largo listo para acceder al ultimo elem.
	add %r15, %r0, %r16	
	call obtener_maximo
	jmpl %r16, 4,%r0
obtener_maximo:
	pop %r2
	pop %r1
	ld %r1, %r2, %r5	!Ultimo elem. del arreglo.
	addcc %r2, -4, %r2
	be termine_vector	!Terminar si solo hay un elem.
	ba maximo			
maximo:
	ld %r1, %r2, %r4	!Elem. actual
	subcc %r5,%r4,%r0	!Comparo %r5 y %r4, si es neg entonces %r4 > %r5
	bneg es_mayor		!Con bpos chequeo si es menor (minimo)
continuar:
	addcc %r2, -4, %r2	
	be termine_vector
	ba maximo
es_mayor:
	add %r4, %r0, %r5	!Nuevo maximo.
	ba vuelta
termine_vector:
	push %r5		!Push del maximo.
	jmpl %r15, 4,%r0
.end
