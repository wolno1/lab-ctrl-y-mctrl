;Selecciona dos pines de cada uno de los puertos B, C y D del microcontrolador. Declara cada uno de estos pines como salida 
;y asígnales un valor en alto para encender los leds conectados a ellos, en total tendrás seis leds en el formato que elijas.

.include "m328pdef.inc" ; Incluir el archivo de definición del microcontrolador

.equ F_CPU = 16000000 ; Definir la frecuencia del microcontrolador

.org 0x00 ; Dirección de inicio del programa

ldi r16, LOW(RAMEND) ; Carga el byte menos significativo de la dirección del final de la RAM en el registro r16
out SPL, r16         ; Guarda el valor de r16 en el registro SPL (puntero de pila de bajo byte)
ldi r16, HIGH(RAMEND) ; Carga el byte más significativo de la dirección del final de la RAM en el registro r16
out SPH, r16          ; Guarda el valor de r16 en el registro SPH (puntero de pila de alto byte)
    
    ; Configurar los pines como salida para los LEDs
    sbi DDRB, 0 ; Pin 8 como salida (puerto B, bit 0)
    sbi DDRB, 1 ; Pin 9 como salida (puerto B, bit 1)
    sbi DDRC, 0 ; Pin A0 como salida (puerto C, bit 0)
    sbi DDRC, 1 ; Pin A1 como salida (puerto C, bit 1)
    sbi DDRD, 2 ; Pin 2 como salida (puerto D, bit 2)
    sbi DDRD, 3 ; Pin 3 como salida (puerto D, bit 3)

    ; Encender los LEDs
    sbi PORTB, 0 ; Poner en alto el pin 8 (puerto B, bit 0)
    sbi PORTB, 1 ; Poner en alto el pin 9 (puerto B, bit 1)
    sbi PORTC, 0 ; Poner en alto el pin A0 (puerto C, bit 0)
    sbi PORTC, 1 ; Poner en alto el pin A1 (puerto C, bit 1)
    sbi PORTD, 2 ; Poner en alto el pin 2 (puerto D, bit 2)
    sbi PORTD, 3 ; Poner en alto el pin 3 (puerto D, bit 3)

loop:
    rjmp loop ; Bucle infinito
