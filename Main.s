.text
.align 2
.global main
.type main,%function

main:

	stmfd sp!, {lr}	@ SP = R13 link register 
	@ Mensaje de bienvenida 
	ldr r0, = cadenaInicio		@ cargar dirección de cadena para imprimir
	bl printf					@ Muestro el mensaje de bienvenida al usuario 
	
	ldr r1 ,=valor		
	ldr r1 ,[r1]
	push {r1}
	
inicio:
	pedirComando1:
		ldr r0 ,=  cadenaComando	@ Cargo el mensaje de ingresar un comando 
		bl printf
		
		ldr r0 ,= caracter			@ Cargo el formato del caracter que ingrese el usuario 
		ldr r1 ,= comando			@ Guardo el valor del caracter que ingrese el usuario 
		bl scanf	
		
		ldr r1 ,= comando			@ Cargo el comando ingresado 
		add r1, #1
		ldrb r1 ,[r1]
		cmp r1, #0
		bne comandoInvalido
		
		ldr r1 ,= comando			@ Cargo el comando ingresado 
		ldrb r1 ,[r1]
		
		cmp r1 , #61				@ Verifico si el caracter es = 
		beq mostrarResultado		@ True -> Muestro el resultado anterior 
		cmp r1, #113				@ Verifico si el caracter es q 
		beq salir					@ True -> El programa termina 
		
		cmp r1, #43					@ Si no es una operación válida
		cmpne r1, #42
		cmpne r1, #77
		cmpne r1, #80
		bne comandoInvalido			@ Imprimo que es un error
		
		push {r1}					@ Else -> Ingreso el caracter a la pila 
		b pedirValor				@ Pido el valor 
				
	
	pedirValor:
		ldr r0, =cadenaValor		@ cargo el mensaje de pedir valor al usuario
		bl printf	
		
		ldr r0, =numero				@ cargar el formato en el que se guarda el valor 
		ldr r1,=valor				@ cargar el valor de valor (valga la redundancia) en r1 para guardarlo 
		bl scanf
		
		cmp r0, #0
		beq valorInvalido
		
		
		ldr r1,=valor				@ Cargo el valor que ingreso el usuario 			
		ldr r1,[r1]
		
		cmp r1, #0
		blt valorInvalido
		
		push {r1}					@ Pongo el valor que ingreso el usuario en la pila para usarlo en las operaciones 
		b imprimir					@ Hora de analizar los datos 
		
		
	imprimir:
		pop {r2,r3,r4}				@ r2 = nuevo numero, r3 = comando, r4 = resultado anterior 
		cmp r3, #43					@ Verifico si el caracter es + 
		bleq suma					@ True -> Sumo el resultado anterior con el nuevo valor ingresado por el usuario 
		cmp r3, #42					@ Verifico si el caracter es * 
		bleq multiplicacion			@ True -> Multiplico el resultado anterior con el nuevo valor ingresado por el usuario 
		cmp r3,#77					@ Verifico si el caracter es M 
		bleq modulo					@ True -> Saco el residuo de la division del resultado anterior con el nuevo valor 
		cmp r3, #80					@ Verifico si el caracter es P 
		bleq potencia				@ True -> Elevo el resultado anterior por la potencia que puso el usuario 
		b pedirComando1				@ El programa sigue 
		
	mostrarResultado:
		pop {r4}					@ Saco el resultado anterior para imprimirlo en la subrutina 
		bl resultado
		b pedirComando1				@ El programa sigue 

valorInvalido:
	ldr r0, =cadenaValorError
	bl printf
	b pedirValor

comandoInvalido:
	ldr r0, =cadenaComandoError
	bl printf
	b pedirComando1

salir: 
	ldr r0 ,= cadenaDespedida		@ Muestro el mensaje de despedida 
	bl puts
	pop {r5}
	
	@ salida correcta 
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	@ R13 = SP 
	bx lr


.data
.align 2 
@ Variables a utilizar 
valor:		.word 0		@ Guarda el numero que ingrese el usuario 

@ Salidas de textos 
cadenaInicio:		.asciz "Bienvenido a la calculadora\n"
cadenaComando:		.asciz "\nIngrese un comando: "
cadenaComandoError:		.asciz "Error. Comando invalido! \n"
cadenaResultado:		.asciz ">> %d\n"
cadenaValor:		.asciz "Ingrese un valor: "
cadenaValorError:		.asciz "Error. Valor invalido! \n"
cadenaDespedida:		.asciz "Muchas gracias por utilizar la calculadora, que tenga una bonita vida :)\n"
caracter:				.asciz "%s"
numero:				.asciz "%d"

comando:	.asciz "  "	@ Guarda el comando que ingrese el usuario 

