#include "registers.h"
#include "ReadWrite_Routines.h"
#include "Reset_Routines.h"
#include "Misc_Routines.h"

extern sfr sbit TFT_BLED;
extern short int ADDRESS_short_1[], ADDRESS_short_2[], ADDRESS_long_1[], ADDRESS_long_2[], PAN_ID_1[], PAN_ID_2[];
extern short int LQI, RSSI2, SEQ_NUMBER, lost_data;
extern int address_RX_FIFO, address_TX_normal_FIFO;

void Initialize() {
  short int i = 0;
  // variable initialization
  LQI = 0;
  RSSI2 = 0;
  SEQ_NUMBER = 0x23;
  lost_data = 0;
  address_RX_FIFO = 0x300;
  address_TX_normal_FIFO = 0;

  for (i = 0; i < 2; i++) {
    ADDRESS_short_1[i] = 1;
    ADDRESS_short_2[i] = 2;
    PAN_ID_1[i] = 3;
    PAN_ID_2[i] = 3;
  }

  for (i = 0; i < 8; i++) {
    ADDRESS_long_1[i] = 1;
    ADDRESS_long_2[i] = 2;
  }

  // Set Chip Select pin as Output
  GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_13);
  GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_10);
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_2);

  // Set PD0 and PD1 as digital input
  GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_0);


  Delay_ms(5);

  // SPI config
  SPI3_Init_Advanced(_SPI_FPCLK_DIV4, _SPI_MASTER  | _SPI_8_BIT |
                     _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
                     _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
                     &_GPIO_MODULE_SPI3_PC10_11_12);
  TFT_BLED = 1;                             // Turn on TFT Backlight

  TFT_Init(320, 240);                       // Initialize TFT display
  TFT_Fill_Screen(CL_WHITE);                // Clear Screen

  pin_reset();                              // Activate reset from pin
  software_reset();                         // Activate software reset
  RF_reset();                               // RF reset
  set_WAKE_from_pin();                      // Set wake from pin

  set_long_address(ADDRESS_long_2);         // Set long address
  set_short_address(ADDRESS_short_2);       // Set short address
  set_PAN_ID(PAN_ID_2);                     // Set PAN_ID

  init_ZIGBEE_nonbeacon();                  // Initialize ZigBee module
  nonbeacon_PAN_coordinator_device();
  set_TX_power(31);                         // Set max TX power
  set_frame_format_filter(1);               // 1 all frames, 3 data frame only
  set_reception_mode(1);                    // 1 normal mode

  pin_wake();                               // Wake from pin
}