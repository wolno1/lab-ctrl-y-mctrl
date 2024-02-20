//make 5 LEDs turn on from left to right and then from right to left

.org 0x0000  ; Dirección de inicio del programa

main:
    ; Configurar los pines de los LEDs como salidas
    ldi r16, (1 << LED_0_BIT) | (1 << LED_1_BIT) | (1 << LED_2_BIT) | (1 << LED_3_BIT) | (1 << LED_4_BIT)
    out DDRB_REG, r16

loop_forward:
    ; Encender los LEDs en orden ascendente (pb0 a pb4)
    ldi r16, (1 << LED_0_BIT)
    out PORTB_REG, r16
    call delay_ms
    ldi r16, (1 << LED_1_BIT)
    out PORTB_REG, r16
    call delay_ms
    ldi r16, (1 << LED_2_BIT)
    out PORTB_REG, r16
    call delay_ms
    ldi r16, (1 << LED_3_BIT)
    out PORTB_REG, r16
    call delay_ms
    ldi r16, (1 << LED_4_BIT)
    out PORTB_REG, r16
    call delay_ms

    ; Apagar los LEDs en orden descendente (pb4 a pb0)
    ldi r16, (1 << LED_3_BIT)
    out PORTB_REG, r16
    call delay_ms
    ldi r16, (1 << LED_2_BIT)
    out PORTB_REG, r16
    call delay_ms
    ldi r16, (1 << LED_1_BIT)
    out PORTB_REG, r16
    call delay_ms

    rjmp loop_forward

; Función de retardo
delay_ms:
    ldi r22, 20     ; Contador exterior para aproximadamente 20 bucles
outer_loop:
    ldi r20, 0xF6   ; Inicializar el contador (248)
inner_loop:
    ldi r21, 0xF6   ; Inicializar el contador interno (248)
innermost_loop:
    dec r21         ; Decrementar el contador interno
    brne innermost_loop ; Saltar si no se ha alcanzado cero
    dec r20         ; Decrementar el contador externo
    brne inner_loop ; Saltar si no se ha alcanzado cero
    dec r22         ; Decrementar el contador exterior
    brne outer_loop ; Saltar si no se ha alcanzado cero
    ret

; Definiciones de registros y bits
.equ DDRB_REG = 0x04   ; Dirección del registro de dirección de datos B (DDR)
.equ PORTB_REG = 0x05  ; Dirección del registro de salida de datos B (PORT)

.equ LED_0_BIT = 0  ; Bit correspondiente al LED 0
.equ LED_1_BIT = 1  ; Bit correspondiente al LED 1
.equ LED_2_BIT = 2  ; Bit correspondiente al LED 2
.equ LED_3_BIT = 3  ; Bit correspondiente al LED 3
.equ LED_4_BIT = 4  ; Bit correspondiente al LED 4
