// DS1722.c
// Zachary Wood
// zwood@hmc.edu
// October 18, 2026
// Source code for DS1722 digital thermometer functions

#include <stdint.h>
#include "DS1722.h"
#include "STM32L432KC_GPIO.h"
#include "STM32L432KC_SPI.h"

static void writeRegister(uint8_t address, uint8_t data) {
    digitalWrite(DS1722_CE, 1);

    spiSendReceive(address);
    spiSendReceive(data);

    digitalWrite(DS1722_CE, 0);
}

static uint8_t readRegister(uint8_t address) {
    digitalWrite(DS1722_CE, 1);

    spiSendReceive(address);
    char data = spiSendReceive(0x00);

    digitalWrite(DS1722_CE, 0);

    return data;
}

void initDS1722() {
    // Set up chip enable
    gpioEnable(gpioPinToPort(DS1722_CE));
    pinMode(DS1722_CE, GPIO_OUTPUT);
    digitalWrite(DS1722_CE, 0);

    // Set up config/status register: set resolution to 8-bit (0b000)
    // and set SD to continuous temperature conversions (0b0)
    writeRegister(DS1722_CFG_WRITE, DS1722_CFG_FIXED7_5);
}

float readTemperature() {
    int16_t data = (readRegister(DS1722_TEMP_MSB_READ) << 8) | readRegister(DS1722_TEMP_LSB_READ);

    return data / 256.0f;
}

void setResolution(int bits) {
    if (bits < 8 || bits > 12) {
        return;
    }

    uint8_t cfg = DS1722_CFG_FIXED7_5
                | (((bits - 8) << DS1722_CFG_R0_Pos) & (DS1722_CFG_R0_Msk | DS1722_CFG_R1_Msk | DS1722_CFG_R2_Msk));

    writeRegister(DS1722_CFG_WRITE, cfg);
}
