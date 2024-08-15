.begin
.org 2048
X:	4
Y:	75
Z:	0
.macro push r
	add %r14, -4, %r14
	st r, %r14
.endmacro
.macro pop r
	ld %r14, r
	add %r14, 4, %r14
.endmacro
.macro obtener_signo r, r_d
	srl r, 31, r_d							!Consigo el signo con un desplazamiento a derecha
.endmacro
.macro obtener_exponente r, r_d
	sethi 1fe00h, r_d						!Cargo con 0111 1111 1000 0000 0000 0000 0000 0000 para quedarme con el exponente
	and r, r_d, r_d
	srl r_d, 23, r_d
.endmacro
.macro obtener_mantisa r, r_d
	sethi 001fffh, r_d						!Cargo con 0000 0000 0111 1111 1111 1111 1111 1111 para quedarme con la mantisa
	add r_d, 2ffh, r_d
	and r, r_d, r_d
.endmacro
main:
	ld [X], %r1
	ld [Y], %r2
	push %r2
	push %r1
	add %r15, %r0, %r16
	call comparar_pto_flotante
	pop %r3
	st %r3, [Z]
	jmpl %r16, 4, %r0
! r1 	-> guarda el primer numero
! r2 	-> guarda el segundo numero
! r5 	-> se utiliza para analizar signo, exponente, mantisa del primer numero
! r6 	-> se utiliza para analizar signo, exponente, mantisa del segundo numero
comparar_pto_flotante:
	pop %r1							!Obtengo el primer numero en r1
	pop %r2							!Obtengo el segundo numero en r2
	obtener_signo %r1,%r5
	obtener_signo %r2,%r6
	subcc %r5, %r6, %r0						!Los resto para ver si uno ya es mayor que el otro
	be signos_iguales						!Si da 0 entonces son iguales los signos
	ba signos_distintos						!Si no da 0 entonces no son iguales los signos
signos_distintos	:							
	addcc %r5, %r0, %r0
	be primero_mayor						!Si r3 es positivo entonces r4 es negativo
	ba segundo_mayor						!Si r3 es negativo entonces r4 es positivo
signos_iguales:							!Si tienen el mismo signo, tengo que seguir analizando. Primero el exponente y despues la mantisa si es necesario
	obtener_exponente %r1,%r5
	obtener_exponente %r2,%r6
	subcc %r5, %r6, %r0						!Los resto para ver si uno ya es mayor que el otro
	be exponentes_iguales						
	ba exponentes_distintos
exponentes_distintos:							
	subcc %r5, %r6, %r0						!Si r3 es mayor, el resultado va a ser positivo
	bpos primero_mayor					
	ba segundo_mayor	
exponentes_iguales:							!Caso ambos exponentes iguales
	obtener_mantisa %r1,%r5
	obtener_mantisa %r2,%r6
	subcc %r5, %r6, %r0						!Resto las mantisas
	be iguales							!Si da 0 significa que los numeros son iguales
	bneg segundo_mayor						! r3 - r4 < 0 ---> r3 < r4
	ba primero_mayor						! r3 - r4 > 0 ---> r3 > r4
primero_mayor:
	add %r0, 1, %r3						!Pongo un 1 en r1
	push %r3							!Hago push del 1 en la pila
	jmpl %r15, 4, %r0
segundo_mayor:
	add %r0, 2, %r3						!Pongo un 2 en r1
	push %r3							!Hago push del 2 en la pila
	jmpl %r15, 4, %r0
iguales:
	push %r0							!Se devuelve 0 ya que los numeros son iguales
	jmpl %r15, 4, %r0
.end
