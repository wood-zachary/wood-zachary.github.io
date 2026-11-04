// DS1722.h
// Zachary Wood
// zwood@hmc.edu
// October 18, 2026
// Header for DS1722 digital thermometer functions

#ifndef STM32L4_DS1722_H
#define STM32L4_DS1722_H

///////////////////////////////////////////////////////////////////////////////
// Definitions
///////////////////////////////////////////////////////////////////////////////

#define DS1722_CE PB1

// ds1722 Register Address Structure Table 4 
#define DS1722_CFG_READ 0x00
#define DS1722_CFG_WRITE 0x80
#define DS1722_TEMP_LSB_READ 0x01
#define DS1722_TEMP_MSB_READ 0x02

#define DS1722_CFG_SD_Pos (0U)
#define DS1722_CFG_SD_Msk (0x1UL << DS1722_CFG_SD_Pos)
#define DS1722_CFG_R0_Pos (1U)
#define DS1722_CFG_R0_Msk (0x1UL << DS1722_CFG_R0_Pos)
#define DS1722_CFG_R1_Pos (2U)
#define DS1722_CFG_R1_Msk (0x1UL << DS1722_CFG_R1_Pos)
#define DS1722_CFG_R2_Pos (3U)
#define DS1722_CFG_R2_Msk (0x1UL << DS1722_CFG_R2_Pos)
#define DS1722_CFG_1SHOT_Pos (4U)
#define DS1722_CFG_1SHOT_Msk (0x1UL << DS1722_CFG_1SHOT_Pos)
#define DS1722_CFG_FIXED7_5 (0x7 << 5)

///////////////////////////////////////////////////////////////////////////////
// Function prototypes
///////////////////////////////////////////////////////////////////////////////

void initDS1722();

float readTemperature();

void setResolution(int bits);

int getResolution();

#endif
