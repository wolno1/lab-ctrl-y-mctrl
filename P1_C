#include <avr/io.h>
#include <util/delay.h> // Para usar la función de delay

#define F_CPU 16000000UL // Frecuencia de trabajo del Arduino UNO

int main(void) {
    // Configurar los pines como salida para los LEDs
    DDRB |= (1 << DDB0) | (1 << DDB1); // Pines 8 y 9 como salida (puerto B)
    DDRC |= (1 << DDC0) | (1 << DDC1); // Pines A0 y A1 como salida (puerto C)
    DDRD |= (1 << DDD2) | (1 << DDD3); // Pines 2 y 3 como salida (puerto D)

    // Encender los LEDs
    PORTB |= (1 << PORTB0) | (1 << PORTB1); // Poner en alto los pines 8 y 9 (puerto B)
    PORTC |= (1 << PORTC0) | (1 << PORTC1); // Poner en alto los pines A0 y A1 (puerto C)
    PORTD |= (1 << PORTD2) | (1 << PORTD3); // Poner en alto los pines 2 y 3 (puerto D)

    while (1) {
        // El código dentro de este bucle se ejecutará continuamente
        // Puedes agregar más lógica aquí si lo necesitas
    }

    return 0;
}
