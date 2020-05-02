.text
.align 2
.global main
.type main,%function

main:

	stmfd sp!, {lr}	/* SP = R13 link register */
	/* Mensaje de bienvenida */
	ldr r0, =cadenaInicio		/* cargar dirección de cadena para imprimir*/
	bl printf			/* r0 la dirección del mensaje a imprimir*  afecta R0*/
	
inicio:
	pedirComando1:
		ldr r0 ,=  cadenaComando	/* Cargo el mensaje de ingresar un comando */
		bl printf
		ldr r0 ,= caracter			/* Cargo el formato del caracter que ingrese el usuario */
		ldr r1 ,= comando			/* Guardo el valor del caracter que ingrese el usuario */
		bl scanf		
		ldr r1 ,= comando			/* Cargo el comando ingresado */
		ldr r1 ,[r1]
		push {r1}					/* Ingreso el comando a la pila para usarlo en las operaciones */
		ldr r1 ,= valor				/* Cargo en r1 el valor de 0 para ingresarlo en la pila (lo dicen las instrucciones) */
		ldr r1 ,[r1]
		push {r1}					/* Ingreso el valor de 0 en la pila */
		b imprimir
		
	pedirComando2: /* Esta etiqueta se ejecuta despues de que el usuario ya ingreso un comando almenos una vez */
		ldr r0 ,=  cadenaComando 	/* Cargo el mensaje de ingresar un comando */
		bl printf
		/* El programa omite por alguna razon el primer scanf, asi que tuve que poner dos -_- */
		ldr r0, =caracter			/* cargar el formato en el que se guarda el comando */
		ldr r1,=comando				/* cargar el valor de comando en r1 para guardarlo */
		bl scanf
		ldr r0, =caracter			/* cargar el formato en el que se guarda el comando */
		ldr r1,=comando				/* cargar el valor de comando en r1 para guardarlo */
		bl scanf
		/* ------------------------------------------------------------------------------------- */
		ldr r1 ,= comando			/* Cargo el comando ingresado */
		ldr r1 ,[r1]
		push {r1}					/* Ingreso el valor a la pila para usarlo en las operaciones */
		b pedirValor	
		
	pedirValor:
		ldr r0, =cadenaValor		/* cargo el mensaje de pedir valor al usuario*/
		bl printf			
		ldr r0, =numero				/* cargar el formato en el que se guarda el valor */
		ldr r1,=valor				/* cargar el valor de valor (valga la redundancia) en r1 para guardarlo */
		bl scanf
		ldr r1,=valor				
		ldr r1,[r1]
		push {r1}					/* Pongo el valor que ingreso el usuario en la pila para usarlo en las operaciones */
		b imprimir
	imprimir:
		/* Esto solo es para ver que si se ingresen bien los resultados (borrar luego) */
		pop {r1}					
		ldr r0 ,= cadenaResultado
		bl printf
		pop {r1}
		ldr r0 ,= cadenaResultado2
		bl printf
		
		
		
		
	
	b pedirComando2


						
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr


.data
.align 2 
/* Variables a utilizar */
comando:	.word ''	/* Guarda el comando que ingrese el usuario */
valor:		.word 0		/* Guarda el numero que ingrese el usuario */

/* Salidas de textos */
cadenaInicio:		.asciz "Bienvenido a la calculadora\n\n"
cadenaComando:		.asciz "Ingrese un comando: "
cadenaResultado:		.asciz ">> %d\n"
cadenaResultado2:		.asciz ">> %c\n"
cadenaValor:		.asciz "Ingrese un valor: "
cadenaError:		.asciz "Error. Valor invalido! \n"
cadenaDespedida:		.asciz "Muchas gracias por utilizar la calculadora, que tenga una bonita vida :)\n"
caracter:				.asciz "%c"
numero:				.asciz "%d"

