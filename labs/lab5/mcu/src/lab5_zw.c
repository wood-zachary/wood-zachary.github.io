// lab5_zw.c
// Interrupts, E155 Lab 5

#include "main.h"

int main(void) {
    // Configure encoder pins as inputs
    gpioEnable(GPIO_PORT_B);
    pinMode(ENCODER_A_PIN, GPIO_INPUT);
    pinMode(ENCODER_B_PIN, GPIO_INPUT);

    // Initialize timer
    RCC->APB1ENR1 |= RCC_APB1ENR1_TIM2EN;
    initTIM(WINDOW_TIM);

    // Enable SYSCFG clock domain in RCC
    RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;

    // Route EXTI1 to PB1 and EXTI7 to PB7
    // Field mask clears bits and field value sets bits
    SYSCFG->EXTICR[0] = (SYSCFG->EXTICR[0] & ~SYSCFG_EXTICR1_EXTI1) | SYSCFG_EXTICR1_EXTI1_PB;
    SYSCFG->EXTICR[1] = (SYSCFG->EXTICR[1] & ~SYSCFG_EXTICR2_EXTI7) | SYSCFG_EXTICR2_EXTI7_PB;

    // Configure interrupt for rising and falling edges of GPIO pins for encoder
    EXTI->IMR1 |= (1 << gpioPinOffset(ENCODER_A_PIN));   // Configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(ENCODER_A_PIN));  // Enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(ENCODER_A_PIN));  // Enable falling edge trigger
    NVIC_EnableIRQ(EXTI1_IRQn);                          // PB1 on EXTI1

    EXTI->IMR1 |= (1 << gpioPinOffset(ENCODER_B_PIN));   // Configure mask bit
    EXTI->RTSR1 |= (1 << gpioPinOffset(ENCODER_B_PIN));  // Enable rising edge trigger
    EXTI->FTSR1 |= (1 << gpioPinOffset(ENCODER_B_PIN));  // Enable falling edge trigger
    NVIC_EnableIRQ(EXTI9_5_IRQn);                        // PB7 on EXTI7, which is shared with lines 5-9

    // Enable interrupts globally
    __enable_irq();

    while(1){
        // start
        delay_millis(WINDOW_TIM, WINDOW_MS);
        // delta
        // compute speed and direction
    }

}

void EXTI1_IRQHandler(void){
    return;
}

void EXTI9_5_IRQHandler(void){
    return;
}