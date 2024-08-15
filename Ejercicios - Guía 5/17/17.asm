.begin
.org 2048
X:	2147549199
Y:	0
main:
	ld [X], %r20
	add %r15, %r0, %r16
	call obtener_sumar_dos_nums
	st %r20, [Y]
	jmpl %r16, 4, %r0
obtener_sumar_dos_nums:
	srl %r20,16,%r1	!Num izq.
	
	sll %r20,16,%r2	!Num der.
	sra %r2,16,%r2	!Vuelvo a derecha.

	addcc %r1,%r2,%r20	!Suma
	jmpl %r15, 4, %r0
.end
!Para obtener el numero izquierdo, muevo 16 lugares a la derecha.

!Para obtener el numero derecho, muevo 16 lugares a la izquierda,
!pisando así al numero de la izquierda. Luego muevo 16 lugares a la 
!derecha para recuperar el numero.
