.text
.align 2

/* Subrutinas para las operaciones */
.global suma
suma:
	push {lr}						/* Guardo la direccion de memoria */
	add r4 , r2, r4					/* Sumo el resultado anterior con el nuevo ingresado por el usuario */
	mov r1, r4						/* Muevo el resultado a r1 para imprimirlo */
	ldr r0 ,= cadenaResultado		/* Formato para el resultado */
	bl printf
	pop {lr}						/* Recupero la direccion de memoria */
	push {r4}						/* Guardo el resultado */
	mov pc,lr

.global multiplicacion
multiplicacion:
	push {lr}						/* Guardo la direccion de memoria */
	mul r4 , r2, r4					/* Multiplico el resultado anterior con el nuevo ingresado por el usuario */
	mov r1, r4						/* Muevo el resultado a r1 para imprimirlo */
	ldr r0 ,= cadenaResultado		/* Formato para el resultado */
	bl printf
	pop {lr}						/* Recupero la direccion de memoria */
	push {r4}						/* Guardo el resultado */
	mov pc,lr
	
.global modulo
modulo:
	push {lr}						/* Guardo la direccion de memoria */
	sub r4, r4 ,r2					/* Le resto al resultado anterior el nuevo ingresado por el usuario */
	cmp r4 ,r2						/* Verifico si aun se puede seguir restando antes de que llegue a un numero menor a r2 */
	bge modulo						/* True -> Sigo con el siclo */
	mov r1, r4						/* Else -> El resultado de r4 es el residuo, lo muevo a r1 para imprimir */
	ldr r0 ,= cadenaResultado		/* Formato para el resultado */
	bl printf
	pop {lr}						/* Recupero la direccion de memoria */
	push {r4}						/* Guardo el resultado */
	mov pc,lr	
	
.global potencia
potencia:
	push {lr}						/* Guardo la direccion de memoria */
	mov r5 , r4						/* Muevo el resultado anterior a r5 para poder hacer el ciclo de la multiplicacion */
	potencia2:						/* Ciclo para la multiplicacion */
		mul r4 , r5					/* Multiplicacion del resultado anterior por si mismo*/
		sub r2 , #1					/* Le resto 1 a la potencia para saber cuando parar */
		cmp r2 ,#1					/* Verifico si se cumplieron los ciclos adecuados (si lo pongo que lo compare con 0 realiza un ciclo mas al que deberia) */
		bgt potencia2				/* True -> El cliclo sigue */
		mov r1, r4					/* Else -> Muevo el resultado a r1 para imprimirlo */
		ldr r0 ,= cadenaResultado	/* Formato para el resultado */
		bl printf
		pop {lr}						/* Recupero la direccion de memoria */
		push {r4}						/* Guardo el resultado */
		mov pc,lr	

.global resultado 
resultado:
	push {lr}						/* Guardo la direccion de memoria */
	mov r1 ,r4						/* Muevo el resultado anterior a r1 para imprimirlo */
	ldr r0 ,= cadenaResultado		/* Formato del resultado */
	bl printf
	pop {lr}						/* Recupero la direccion de memoria */
	push {r4}						/* Guardo el resultado */
	mov pc,lr
	

	
.data
.align 2 
/* Salidas de textos */
cadenaResultado:		.asciz ">> %d\n"
