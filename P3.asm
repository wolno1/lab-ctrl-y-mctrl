//This code turns on LEDs based on a dip switch, simple code

.include "m328pdef.inc" ; Incluir archivo de definiciones para el ATmega328P

.def dipSwitchState = R16 ; Registro para almacenar el estado de los dip switches

.org 0x0000 ; Dirección de inicio

rjmp inicio ; Salto a la etiqueta "inicio" al encender el microcontrolador

.org 0x0012 ; Dirección de la interrupción

reti ; Retorno de la interrupción (no se utiliza en este ejemplo)

inicio:
  ; Configurar pines de los dip switches como entrada
  ldi r16, 0xFF ; Cargar 0xFF (11111111 en binario) en R16
  out DDRD, r16 ; Establecer todos los pines del puerto D como entradas
  
  ; Configurar pines de los LEDs como salida
  ldi r16, 0b00111111 ; Cargar 0b00111111 en R16 (los pines 8 al 13)
  out DDRB, r16 ; Establecer los pines del puerto B como salidas
  
loop:
  ; Leer el estado de los dip switches y actualizar dipSwitchState usando máscaras de bits
  in r16, PIND ; Leer el estado de los dip switches del puerto D y almacenar en R16
  mov dipSwitchState, r16 ; Copiar el estado de los dip switches a la variable dipSwitchState
  
  ; Encender o apagar los LEDs según el estado de los dip switches
  mov r17, dipSwitchState ; Copiar el estado de los dip switches a R17
  andi r17, 0b00111111 ; Aplicar una máscara para mantener solo los 6 bits menos significativos
  out PORTB, r17 ; Establecer el estado de los LEDs según el estado de los dip switches
  
  rcall delay ; Llamar a la subrutina de delay
  rjmp loop ; Volver al comienzo del bucle

delay:
  ldi r18, 100 ; Cargar el valor 100 en R18 para el retardo
delay_loop:
  dec r18 ; Decrementar R18
  brne delay_loop ; Saltar a delay_loop si R18 no es cero
  ret ; Retornar de la subrutina
