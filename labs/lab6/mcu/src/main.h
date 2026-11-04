#ifndef MAIN_H
#define MAIN_H

#include "../lib/STM32L432KC.h"
#include "../lib/DS1722.h"

///////////////////////////////////////////////////////////////////////////////
// Custom defines
///////////////////////////////////////////////////////////////////////////////

#define LED_PIN PA6
#define REQ_LED_ON "ledon"
#define REQ_LED_OFF "ledoff"

#define SPI_BR 0b100  // 80 MHz / 32 = 2.5 MHz
#define SPI_CPOL 0
#define SPI_CPHA 1
#define BUFF_LEN 32
#define REQ_RES_8 "res8"
#define REQ_RES_9 "res9"
#define REQ_RES_10 "res10"
#define REQ_RES_11 "res11"
#define REQ_RES_12 "res12"

#endif // MAIN_H
