//Use 3 buttons and 3 LEDs
//Turn LED 1 on when a button is pressed (Any button or combination)
//Turn LED 2 on when all buttons are pressed
//Turn LED 3 on when there are no buttons pressed
//Turn LED 4 on when not all buttons are pressed

.include "m328pdef.inc" ; Incluir el archivo de definición del microcontrolador

; Definir constantes de pines
.equ SW0 = 2 ; Botón 1 - PD2
.equ SW1 = 3 ; Botón 2 - PD3
.equ SW2 = 4 ; Botón 3 - PD4
.equ LED0 = PB1 ; LED 1
.equ LED1 = PB2 ; LED 2
.equ LED2 = PB3 ; LED 3
.equ LED3 = PB4 ; LED 4

; Definir máscaras de bits para puertos
.equ SWITCHES_MASK = (1<<SW0) | (1<<SW1) | (1<<SW2)
.equ LEDS_MASK = (1<<LED0) | (1<<LED1) | (1<<LED2) | (1<<LED3)

; Inicializar puertos
ldi r16, (1<<LED0) | (1<<LED1) | (1<<LED2) | (1<<LED3) ; Configurar todos los LEDs como salidas
out DDRB, r16 ; Puertos B como salidas
ldi r16, (1<<SW0) | (1<<SW1) | (1<<SW2) ; Configurar pines de botones como entrada
out DDRD, r16 ; Puertos D como entradas
ldi r16, (1<<SW0) | (1<<SW1) | (1<<SW2) ; Activar resistencias pull-up en pines de botones
out PORTD, r16

loop:
; Leer estado de los botones
in r16, PIND ; Leer el estado de los botones desde el registro PIND
; Verificar condiciones para LEDs
; LED 1 - Enciende cuando todos los botones están presionados
ldi r17, SWITCHES_MASK
cp r16, r17 ; Compara el estado de los botones con la máscara
breq all_buttons_pressed ; Salta si todos los botones están presionados
cbi PORTB, LED0 ; Apaga LED0 si no se cumplen las condiciones
rjmp led2_check ; Saltar a verificar la siguiente condición
all_buttons_pressed:
sbi PORTB, LED0 ; Enciende LED0 si todos los botones están presionados
led2_check:
; LED 2 - Enciende cuando cualquier botón está presionado
tst r16 ; Verifica si algún botón está presionado
brne any_button_pressed ; Salta si algún botón está presionado
cbi PORTB, LED1 ; Apaga LED1 si ningún botón está presionado
rjmp led3_check ; Saltar a verificar la siguiente condición
any_button_pressed:
sbi PORTB, LED1 ; Enciende LED1 si algún botón está presionado
led3_check:
; LED 3 - Enciende cuando tres botones están presionados
ldi r17, SWITCHES_MASK ; Máscara para verificar si todos los botones están presionados
cp r16, r17 ; Compara el estado de los botones con la máscara
breq three_buttons_pressed ; Salta si todos los botones están presionados
sbi PORTB, LED2 ; Enciende LED2 si no todos los botones están presionados
rjmp led4_check ; Saltar a verificar la siguiente condición
three_buttons_pressed:
cbi PORTB, LED2 ; Apaga LED2 si todos los botones están presionados
led4_check:
; LED 4 - Enciende cuando cualquier botón está presionado
tst r16 ; Verifica si algún botón está presionado
breq no_button_pressed_led4 ; Salta si ningún botón está presionado
cbi PORTB, LED3 ; Apaga LED3 si algún botón está presionado
rjmp end_loop ; Salta al final del bucle
no_button_pressed_led4:
sbi PORTB, LED3 ; Enciende LED3 si ningún botón está presionado
end_loop:
rjmp loop ; Volver al principio del bucle

; Fin del código
