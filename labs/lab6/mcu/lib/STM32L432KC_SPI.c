// STM32L432KC_SPI.c
// Zachary Wood
// zwood@hmc.edu
// October 18, 2026
// Source code for SPI functions

#include "STM32L432KC_SPI.h"
#include "STM32L432KC_GPIO.h"
#include "STM32L432KC_RCC.h"

void initSPI(int br, int cpol, int cpha) {
    // Derived from rm0394 section 40.4.7 and section 40.6

    // Disable SPI
    SPI1->CR1 &= ~(SPI_CR1_SPE_Msk);

    // Write proper GPIO registers
    GPIO_TypeDef* GPIO_Base = gpioPinToBase(SPI_SCK);
    int GPIO_Port = gpioPinToPort(SPI_SCK);

    gpioEnable(GPIO_Port);

    pinMode(SPI_SCK, GPIO_ALT);
    pinMode(SPI_MISO, GPIO_ALT);
    pinMode(SPI_MOSI, GPIO_ALT);

    GPIO_Base->AFR[0] &= ~(GPIO_AFRL_AFSEL3_Msk);
    GPIO_Base->AFR[0] &= ~(GPIO_AFRL_AFSEL4_Msk);
    GPIO_Base->AFR[0] &= ~(GPIO_AFRL_AFSEL5_Msk);

    GPIO_Base->AFR[0] |= 5 << GPIO_AFRL_AFSEL3_Pos;
    GPIO_Base->AFR[0] |= 5 << GPIO_AFRL_AFSEL4_Pos;
    GPIO_Base->AFR[0] |= 5 << GPIO_AFRL_AFSEL5_Pos;

    // Write to SPI_CR1: baud rate, CPOL and CPHA, full duplex, MSB first,
    // no CRC used, internal NSS is high and DS1722's CE driven with GPIO pin
    // so SSM = 1 and SSI = 1, master 
    RCC->APB2ENR |= RCC_APB2ENR_SPI1EN_Msk;

    uint32_t cr1 = ((br << SPI_CR1_BR_Pos) & SPI_CR1_BR_Msk)
                 | ((cpol << SPI_CR1_CPOL_Pos) & SPI_CR1_CPOL_Msk)
                 | ((cpha << SPI_CR1_CPHA_Pos) & SPI_CR1_CPHA_Msk)
                 | SPI_CR1_SSM
                 | SPI_CR1_SSI
                 | SPI_CR1_MSTR;
    SPI1->CR1 = cr1;

    // Write to SPI_CR2: 8-bit data length, SSOE skipped since set by software,
    // Motorola frame format, NSSP skipped since CPHA = 1, RXNE event generated
    // if FIFO level is >= 8 bits, LDMA_TX and LDMA_RX skipped since DMA unused
    uint32_t cr2 = ((0b0111 << SPI_CR2_DS_Pos) & SPI_CR2_DS_Msk)
                 | SPI_CR2_FRXTH;
    SPI1->CR2 = cr2;

    // SPI_CRCPR skipped since CRC not enabled

    // DMA registers skipped since DMA is unused

    // Enable SPI
    SPI1->CR1 |= 1 << SPI_CR1_SPE_Pos;
}

char spiSendReceive(char send) {
    return '0';
}
