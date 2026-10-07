// lab5_zw.c
// Interrupts, E155 Lab 5

#include "main.h"

static volatile uint32_t encoder_count = 0;

int main(void) {
    // Configure encoder pins as inputs
    gpioEnable(GPIO_PORT_B);
    pinMode(ENCODER_A_PIN, GPIO_INPUT);
    pinMode(ENCODER_B_PIN, GPIO_INPUT);

    // Initialize timer
    RCC->APB1ENR1 |= RCC_APB1ENR1_TIM2EN;
    initTIM(WINDOW_TIM);

    // Interrupt on both edges of both encoder channels
    extiEnableEdges(ENCODER_A_PIN, EXTI1_IRQn);
    extiEnableEdges(ENCODER_B_PIN, EXTI9_5_IRQn);
    __enable_irq();

    while(1) {
        uint32_t start = encoder_count;

        delay_millis(WINDOW_TIM, WINDOW_MS);

        // Unsigned subtraction is always exact across counter wraparound
        // The cast recovers the sign but is only valid while |net counts per window| < 2^31,
        // which is around 1.3 million revolutions per second with CPR = 1632
        int32_t delta = (int32_t)(encoder_count - start);

        float speed = (float)delta * MS_PER_S / (ENCODER_CPR * WINDOW_MS);

        // Resolution is 1 count per window, 1/1632 = 6.1e-4 revolutions per second
        // at WINDOW_MS = 1000, so digits past the 4th decimal carry no information.
        if (delta > 0) {
            printf("Forward: %.4f revolutions per second\n", speed);
        } else if (delta < 0) {
            printf("Reverse: %.4f revolutions per second\n", -speed);
        } else {
            printf("Motor stopped: zero revolutions per second.\n");
        }
    }

}

// EXTI->PR1 = EXTI pending register 1
// PIFn = pending interrupt flag on line n
// A leads B by 90 degrees, so the order in which (A, B) changes indicates direction.
// Forward: 00, 10, 11, 01
// Reverse: 00, 01, 11, 10

void EXTI1_IRQHandler(void){
    if (EXTI->PR1 & EXTI_PR1_PIF1) {
        EXTI->PR1 = EXTI_PR1_PIF1;  // clear the interrupt by writing 1

        // A just changed, so A != B if the encoder is moving forward
        if (digitalRead(ENCODER_A_PIN) != digitalRead(ENCODER_B_PIN)) {
            encoder_count++;
        } else {
            encoder_count--;
        }
    }
}

void EXTI9_5_IRQHandler(void){
    if (EXTI->PR1 & EXTI_PR1_PIF5) {
        EXTI->PR1 = EXTI_PR1_PIF5;  // clear the interrupt by writing 1

        // B just changed, so A == B if the encoder is moving forward
        if (digitalRead(ENCODER_A_PIN) == digitalRead(ENCODER_B_PIN)) {
            encoder_count++;
        } else {
            encoder_count--;
        }
    }
}