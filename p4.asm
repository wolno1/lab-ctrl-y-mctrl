//You introduce a binary number through the dip switch, the number it's displayed in the 7-segment display on decimal

.include "m328pdef.inc"

.equ SWITCH_PORT = PORTB
.equ DISPLAY_PORT = PORTD

.equ SWITCH_PIN = PINB
.equ DISPLAY_DDR = DDRD

.equ SWITCH_MASK = 0b00000111

.org 0x0000
  rjmp RESET

RESET:
  ldi r16, HIGH(RAMEND)
  out SPH, r16
  ldi r16, LOW(RAMEND)
  out SPL, r16

  ; Configurar puertos
  ldi r16, 0xFF ; Configurar todos los pines de salida para el display
  out DISPLAY_DDR, r16
  ldi r16, (1 << PB0) | (1 << PB1) | (1 << PB2) ; Configurar pines del dip switch como entrada con pull-up
  out PORTB, r16

main_loop:
  ; Leer estado del dip switch
  in r16, SWITCH_PIN
  andi r16, SWITCH_MASK
  
  ; Mostrar el número correspondiente en el display de 7 segmentos
  cpi r16, 0
  brne not_zero
  ldi r17, 0b00111111 ; Representación del número 0 en el display
  out DISPLAY_PORT, r17
  rjmp end_switch

not_zero:
  cpi r16, 1
  brne not_one
  ldi r17, 0b00000110 ; Representación del número 1 en el display
  out DISPLAY_PORT, r17
  rjmp end_switch

not_one:
  cpi r16, 2
  brne not_two
  ldi r17, 0b01011011 ; Representación del número 2 en el display
  out DISPLAY_PORT, r17
  rjmp end_switch

not_two:
  cpi r16, 3
  brne not_three
  ldi r17, 0b01001111 ; Representación del número 3 en el display
  out DISPLAY_PORT, r17
  rjmp end_switch

not_three:
  cpi r16, 4
  brne not_four
  ldi r17, 0b01100110 ; Representación del número 4 en el display
  out DISPLAY_PORT, r17
  rjmp end_switch

not_four:
  cpi r16, 5
  brne not_five
  ldi r17, 0b01101101 ; Representación del número 5 en el display
  out DISPLAY_PORT, r17
  rjmp end_switch

not_five:
  cpi r16, 6
  brne not_six
  ldi r17, 0b01111101 ; Representación del número 6 en el display
  out DISPLAY_PORT, r17
  rjmp end_switch

not_six:
  ldi r17, 0b00000111 ; Representación del número 7 en el display
  out DISPLAY_PORT, r17

end_switch:
  rjmp main_loop
