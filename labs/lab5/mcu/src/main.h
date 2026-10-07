// main.h
// Josh Brake
// jbrake@hmc.edu
// 10/31/22

#ifndef MAIN_H
#define MAIN_H

#include "../lib/STM32L432KC.h"

///////////////////////////////////////////////////////////////////////////////
// Custom defines
///////////////////////////////////////////////////////////////////////////////

// PB1 and PB7 are adjacent on the breakout board, both are FT, both are
// on port B, and they have separate EXTI lines and handlers.
#define ENCODER_A_PIN PB1  // DS11451 Tables 13-14, FT Pins
#define ENCODER_B_PIN PB7  // DS11451 Tables 13-14, FT Pins
#define WINDOW_TIM TIM2
#define WINDOW_MS 1000

#endif // MAIN_H