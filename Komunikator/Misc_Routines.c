#include "registers.h"
#include "ReadWrite_Routines.h"
#include "Reset_Routines.h"

extern sfr sbit WAKE_;               // WAKE pin
extern sfr sbit INT;               // INT pin

/*
 *  Interrupt
 */
void enable_interrupt() {
 write_ZIGBEE_short(INTCON_M, 0x00);   //0x00  all INTerrupts are enable
}

/*
 *  Set channel
 */
void set_channel(short int channel_number) {               // 11-26 possible channels
  if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
  switch(channel_number) {
    case 11:
      write_ZIGBEE_long(RFCON0, 0x02);  // 0x02 for 11. channel
      break;
    case 12:
      write_ZIGBEE_long(RFCON0, 0x12);  // 0x12 for 12. channel
      break;
    case 13:
      write_ZIGBEE_long(RFCON0, 0x22);  // 0x22 for 13. channel
      break;
    case 14:
      write_ZIGBEE_long(RFCON0, 0x32);  // 0x32 for 14. channel
      break;
    case 15:
      write_ZIGBEE_long(RFCON0, 0x42);  // 0x42 for 15. channel
      break;
    case 16:
      write_ZIGBEE_long(RFCON0, 0x52);  // 0x52 for 16. channel
      break;
    case 17:
      write_ZIGBEE_long(RFCON0, 0x62);  // 0x62 for 17. channel
      break;
    case 18:
      write_ZIGBEE_long(RFCON0, 0x72);  // 0x72 for 18. channel
      break;
    case 19:
      write_ZIGBEE_long(RFCON0, 0x82);  // 0x82 for 19. channel
      break;
    case 20:
      write_ZIGBEE_long(RFCON0, 0x92);  // 0x92 for 20. channel
      break;
    case 21:
      write_ZIGBEE_long(RFCON0, 0xA2);  // 0xA2 for 21. channel
      break;
    case 22:
      write_ZIGBEE_long(RFCON0, 0xB2);  // 0xB2 for 22. channel
      break;
    case 23:
      write_ZIGBEE_long(RFCON0, 0xC2);  // 0xC2 for 23. channel
      break;
    case 24:
      write_ZIGBEE_long(RFCON0, 0xD2);  // 0xD2 for 24. channel
      break;
    case 25:
      write_ZIGBEE_long(RFCON0, 0xE2);  // 0xE2 for 25. channel
      break;
    case 26:
      write_ZIGBEE_long(RFCON0, 0xF2);  // 0xF2 for 26. channel
      break;
  }
  RF_reset();
}

/*
 *  Set CCA mode
 */
void set_CCA_mode(short int CCA_mode) {
  short int temp = 0;
  switch(CCA_mode) {
        case 1: {                               // ENERGY ABOVE THRESHOLD
          temp = read_ZIGBEE_short(BBREG2);
          temp = temp | 0x80;                   // 0x80 mask
          temp = temp & 0xDF;                   // 0xDF mask
          write_ZIGBEE_short(BBREG2, temp);
          write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
        }
        break;

        case 2: {                               // CARRIER SENSE ONLY
          temp = read_ZIGBEE_short(BBREG2);
          temp = temp | 0x40;                   // 0x40 mask
          temp = temp & 0x7F;                   // 0x7F mask
          write_ZIGBEE_short(BBREG2, temp);

          temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
          temp = temp | 0x38;
          temp = temp & 0xFB;
          write_ZIGBEE_short(BBREG2, temp);
        }
        break;

        case 3: {                               // CARRIER SENSE AND ENERGY ABOVE THRESHOLD
          temp = read_ZIGBEE_short(BBREG2);
          temp = temp | 0xC0;                   // 0xC0 mask
          write_ZIGBEE_short(BBREG2, temp);

          temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
          temp = temp | 0x38;                   // 0x38 mask
          temp = temp & 0xFB;                   // 0xFB mask
          write_ZIGBEE_short(BBREG2, temp);

          write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
        }
        break;
    }
 }

/*
 *  Set RSSI mode
 */
void set_RSSI_mode(short int RSSI_mode) {       // 1 for RSSI1, 2 for RSSI2 mode
  short int temp = 0;

  switch(RSSI_mode) {
    case 1: {
      temp = read_ZIGBEE_short(BBREG6);
      temp = temp | 0x80;                       // 0x80 mask for RSSI1 mode
      write_ZIGBEE_short(BBREG6, temp);
    }
    break;

    case 2:
      write_ZIGBEE_short(BBREG6, 0x40);         // 0x40 data for RSSI2 mode
      break;
  }
}

/*
 * Set type of device
 */
void nonbeacon_PAN_coordinator_device() {
  short int temp = 0;

  temp = read_ZIGBEE_short(RXMCR);
  temp = temp | 0x08;                 // 0x08 mask for PAN coordinator
  write_ZIGBEE_short(RXMCR, temp);

  temp = read_ZIGBEE_short(TXMCR);
  temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
  write_ZIGBEE_short(TXMCR, temp);

  write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO are 15
}

void nonbeacon_coordinator_device() {
  short int temp = 0;

  temp = read_ZIGBEE_short(RXMCR);
  temp = temp | 0x04;                 // 0x04 mask for coordinator
  write_ZIGBEE_short(RXMCR, temp);

  temp = read_ZIGBEE_short(TXMCR);
  temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
  write_ZIGBEE_short(TXMCR, temp);

  write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO  are 15
}

void nonbeacon_device() {
  short int temp = 0;

  temp = read_ZIGBEE_short(RXMCR);
  temp = temp & 0xF3;                 // 0xF3 mask for PAN coordinator and coordinator
  write_ZIGBEE_short(RXMCR, temp);

  temp = read_ZIGBEE_short(TXMCR);
  temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
  write_ZIGBEE_short(TXMCR, temp);
}

/*
 * ACK request
 */
void set_ACK() {
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp | 0x04;                 // 0x04 mask for set ACK
  write_ZIGBEE_short(TXNCON, temp);
}

void set_not_ACK() {
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp & (!0x04);              // 0x04 mask for set not ACK
  write_ZIGBEE_short(TXNCON, temp);
}

/*
 *  Encrypt
 */
void set_encrypt() {
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp | 0x02;                 // mask for set encrypt
  write_ZIGBEE_short(TXNCON, temp);
}

void set_not_encrypt(void){
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp & (!0x02);              // mask for set not encrypt
  write_ZIGBEE_short(TXNCON, temp);
}

/*
 * Interframe spacing
 */
void set_IFS_recomended() {
  short int temp = 0;

  write_ZIGBEE_short(RXMCR, 0x93);    // Min SIFS Period

  temp = read_ZIGBEE_short(TXPEND);
  temp = temp | 0x7C;                 // MinLIFSPeriod
  write_ZIGBEE_short(TXPEND, temp);

  temp = read_ZIGBEE_short(TXSTBL);
  temp = temp | 0x90;                 // MinLIFSPeriod
  write_ZIGBEE_short(TXSTBL, temp);

  temp = read_ZIGBEE_short(TXTIME);
  temp = temp | 0x31;                 // TurnaroundTime
  write_ZIGBEE_short(TXTIME, temp);
}

void set_IFS_default() {
  short int temp = 0;

  write_ZIGBEE_short(RXMCR, 0x75);    // Min SIFS Period

  temp = read_ZIGBEE_short(TXPEND);
  temp = temp | 0x84;                 // Min LIFS Period
  write_ZIGBEE_short(TXPEND, temp);

  temp = read_ZIGBEE_short(TXSTBL);
  temp = temp | 0x50;                 // Min LIFS Period
  write_ZIGBEE_short(TXSTBL, temp);

  temp = read_ZIGBEE_short(TXTIME);
  temp = temp | 0x41;                 // Turnaround Time
  write_ZIGBEE_short(TXTIME, temp);
}

/*
 * Reception mode
 */
void set_reception_mode(short int r_mode) { // 1 normal, 2 error, 3 promiscuous mode
  short int temp = 0;

  switch(r_mode) {
   case 1: {
     temp = read_ZIGBEE_short(RXMCR);      // normal mode
     temp = temp & (!0x03);                // mask for normal mode
     write_ZIGBEE_short(RXMCR, temp);
   }
   break;

   case 2: {
     temp = read_ZIGBEE_short(RXMCR);      // error mode
     temp = temp & (!0x01);                // mask for error mode
     temp = temp | 0x02;                   // mask for error mode
     write_ZIGBEE_short(RXMCR, temp);
   }
   break;

   case 3: {
     temp = read_ZIGBEE_short(RXMCR);      // promiscuous mode
     temp = temp & (!0x02);                // mask for promiscuous mode
     temp = temp | 0x01;                   // mask for promiscuous mode
     write_ZIGBEE_short(RXMCR, temp);
   }
   break;
  }
}

/*
 *  Frame format filter
 */
void set_frame_format_filter(short int fff_mode) {   // 1 all frames, 2 command only, 3 data only, 4 beacon only
  short int temp = 0;

  switch(fff_mode) {
   case 1: {
     temp = read_ZIGBEE_short(RXFLUSH);      // all frames
     temp = temp & (!0x0E);                  // mask for all frames
     write_ZIGBEE_short(RXFLUSH, temp);
   }
   break;

   case 2: {
     temp = read_ZIGBEE_short(RXFLUSH);      // command only
     temp = temp & (!0x06);                  // mask for command only
     temp = temp | 0x08;                     // mask for command only
     write_ZIGBEE_short(RXFLUSH, temp);
   }
   break;

   case 3: {
     temp = read_ZIGBEE_short(RXFLUSH);      // data only
     temp = temp & (!0x0A);                  // mask for data only
     temp = temp | 0x04;                     // mask for data only
     write_ZIGBEE_short(RXFLUSH, temp);
   }
   break;

   case 4: {
     temp = read_ZIGBEE_short(RXFLUSH);      // beacon only
     temp = temp & (!0x0C);                  // mask for beacon only
     temp = temp | 0x02;                     // mask for beacon only
     write_ZIGBEE_short(RXFLUSH, temp);
   }
   break;
  }
}

/*
 *  Flush RX FIFO pointer
 */
void flush_RX_FIFO_pointer() {
  short int temp;

  temp = read_ZIGBEE_short(RXFLUSH);
  temp = temp | 0x01;                        // mask for flush RX FIFO
  write_ZIGBEE_short(RXFLUSH, temp);
}

/*
 * Address
 */
void set_short_address(short int * address) {
  write_ZIGBEE_short(SADRL, address[0]);
  write_ZIGBEE_short(SADRH, address[1]);
}

void set_long_address(short int * address) {
  short int i = 0;

  for(i = 0; i < 8; i++) {
    write_ZIGBEE_short(EADR0 + i, address[i]);   // 0x05 address of EADR0
  }
}

void set_PAN_ID(short int * address) {
  write_ZIGBEE_short(PANIDL, address[0]);
  write_ZIGBEE_short(PANIDH, address[1]);
}

/*
 * Wake
 */
void set_wake_from_pin() {
  short int temp = 0;

  WAKE_ = 0;
  temp = read_ZIGBEE_short(RXFLUSH);
  temp = temp | 0x60;                     // mask
  write_ZIGBEE_short(RXFLUSH, temp);

  temp = read_ZIGBEE_short(WAKECON);
  temp = temp | 0x80;
  write_ZIGBEE_short(WAKECON, temp);
}

void pin_wake() {
  WAKE_ = 1;
  Delay_ms(5);
}

/*
 * PLL
 */
void enable_PLL() {
  write_ZIGBEE_long(RFCON2, 0x80);       // mask for PLL enable
}

void disable_PLL() {
  write_ZIGBEE_long(RFCON2, 0x00);       // mask for PLL disable
}

/*
 * Tx power
 */
void set_TX_power(unsigned short int power) {             // 0-31 possible variants
  if((power < 0) || (power > 31))
    power = 31;
  power = 31 - power;                                     // 0 max, 31 min -> 31 max, 0 min
  power = ((power & 0b00011111) << 3) & 0b11111000;       // calculating power
  write_ZIGBEE_long(RFCON3, power);
}

/*
 * Init ZIGBEE module
 */
void init_ZIGBEE_basic() {
  write_ZIGBEE_short(PACON2, 0x98);   // Initialize FIFOEN = 1 and TXONTS = 0x6
  write_ZIGBEE_short(TXSTBL, 0x95);   // Initialize RFSTBL = 0x9
  write_ZIGBEE_long(RFCON1, 0x01);    // Initialize VCOOPT = 0x01
  enable_PLL();                       // Enable PLL (PLLEN = 1)
  write_ZIGBEE_long(RFCON6, 0x90);    // Initialize TXFIL = 1 and 20MRECVR = 1
  write_ZIGBEE_long(RFCON7, 0x80);    // Initialize SLPCLKSEL = 0x2 (100 kHz Internal oscillator)
  write_ZIGBEE_long(RFCON8, 0x10);    // Initialize RFVCO = 1
  write_ZIGBEE_long(SLPCON1, 0x21);   // Initialize CLKOUTEN = 1 and SLPCLKDIV = 0x01
}

void init_ZIGBEE_nonbeacon() {
  init_ZIGBEE_basic();
  set_CCA_mode(1);     // Set CCA mode to ED and set threshold
  set_RSSI_mode(2);    // RSSI2 mode
  enable_interrupt();  // Enables all interrupts
  set_channel(11);     // Channel 11
  RF_reset();
}

char Debounce_INT() {
  char i = 0, j = 0, intn_d = 0;
  for(i = 0; i < 5; i++) {
    intn_d = INT;
    if (intn_d == 1)
      j++;
  }
  if (j > 2)
    return 1;
  else 
    return 0;
}