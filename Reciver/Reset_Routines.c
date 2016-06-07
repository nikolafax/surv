#include "registers.h"
#include "ReadWrite_Routines.h"

extern sfr sbit RST;               // RST pin
//extern sfr sbit RST_Direction;     // RST pin direction

/*
 * Reset functions
 */

// Reset from pin
void pin_reset() {
  RST = 0;  // activate reset
  Delay_ms(5);
  RST = 1;  // deactivate reset
  Delay_ms(5);
}

void PWR_reset() {
  write_ZIGBEE_short(SOFTRST, 0x04);   // 0x04  mask for RSTPWR bit
}

void BB_reset() {
  write_ZIGBEE_short(SOFTRST, 0x02);   // 0x02 mask for RSTBB bit
}

void MAC_reset() {
  write_ZIGBEE_short(SOFTRST, 0x01);   // 0x01 mask for RSTMAC bit
}

void software_reset() {                // PWR_reset,BB_reset and MAC_reset at once
  write_ZIGBEE_short(SOFTRST, 0x07);
}

void RF_reset() {
  short int temp = 0;
  temp = read_ZIGBEE_short(RFCTL);
  temp = temp | 0x04;                  // mask for RFRST bit
  write_ZIGBEE_short(RFCTL, temp);
  temp = temp & (!0x04);               // mask for RFRST bit
  write_ZIGBEE_short(RFCTL, temp);
  Delay_ms(1);
}