.begin
.org 2048
array .dwb 30
largo: 120
main:
	ld [largo], %r1	!Largo
	add %r1, %r0, %r5	!Copio largo
	ld [array], %r2	!Direccion
	addcc %r0, %r0, %r4	!Contador
sumar_elems_array:
	andcc %r5, %r0, %r0
	be chequear_par_impar
	addcc %r5, -4, %r5
	ld %r5, %r2, %r3	!Valor actual
	addcc %r3, %r4, %r4	!Sumar al contador
	bvs overflow
	ba sumar_elems_array
chequear_par_impar:
	sll %r4, 31, %r4	!Shift izq. 31 lugares (quiero el ultimo bit)
	srl %r4, 31, %r4	!Llevo el ultimo bit a su pos. inicial
	addcc %r4, %r0, %r0	
	be impar
	add %r0, 1, %r4	!Es par, devuelvo 1.
	sethi FFFFh, %r6
reset_array_par:
	addcc %r1, -4, %r1
	be terminar
	st %r6, %r2, %r1		
	ba reset_array_par
impar:
	addcc %r0, %r0, %r4
	ba terminar
overflow:
	addcc %r0, -1, %r4
	ba reset_array
reset_array:
	addcc %r1, -4, %r1
	be terminar
	st %r0, %r2, %r1		
	ba poner_en_cero_el_vector
terminar:
	jmpl %r15, 4, %r0
.end