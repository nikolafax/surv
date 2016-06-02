#include "registers.h"
#include "Misc_Routines.h"

extern sfr sbit CS;                 // CS pin
//extern sfr sbit CS_Direction;     // CS pin direction

const unsigned short int DATA_LENGHT = 3;
const unsigned short int HEADER_LENGHT = 11;

int address_RX_FIFO, address_TX_normal_FIFO;
short int data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2 + 1 + 1], lost_data;

short int ADDRESS_short_1[2], ADDRESS_long_1[8];        // Source address
short int ADDRESS_short_2[2], ADDRESS_long_2[8];        // Destination address
short int PAN_ID_1[2];               // Source PAN ID
short int PAN_ID_2[2];               // Destination PAN ID
short int DATA_RX[DATA_LENGHT], DATA_TX[DATA_LENGHT], data_TX_normal_FIFO[DATA_LENGHT + HEADER_LENGHT + 2];
short int LQI, RSSI2, SEQ_NUMBER;

/*
 * Functions for reading and writing registers in short address memory space
 */

// write data in short address register
void write_ZIGBEE_short(short int address, short int data_r) {
  CS = 0;

  address = ((address << 1) & 0b01111111) | 0x01; // calculating addressing mode
  SPI3_Write(address);       // addressing register
  SPI3_Write(data_r);        // write data in register

  CS = 1;
}

// read data from short address register
short int read_ZIGBEE_short(short int address) {
  short int data_r = 0, dummy_data_r = 0;

  CS = 0;

  address = (address << 1) & 0b01111110;      // calculating addressing mode
  SPI3_Write(address);                        // addressing register
  data_r = SPI3_Read(dummy_data_r);           // read data from register
  CS = 1;
  return data_r;
}

/*
 * Functions for reading and writing registers in long address memory space
 */
// Write data in long address register
void write_ZIGBEE_long(int address, short int data_r) {
  short int address_high = 0, address_low = 0;

  CS = 0;

  address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;  // calculating addressing mode
  address_low  = (((short int)(address << 5)) & 0b11100000) | 0x10;  // calculating addressing mode
  SPI3_Write(address_high);           // addressing register
  SPI3_Write(address_low);            // addressing register
  SPI3_Write(data_r);                 // write data in registerr

  CS = 1;
}

// Read data from long address register
short int read_ZIGBEE_long(int address) {
  short int data_r = 0, dummy_data_r = 0;
  short int address_high = 0, address_low = 0;

  CS = 0;

  address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;  //calculating addressing mode
  address_low  = ((short int)(address << 5) & 0b11100000);         //calculating addressing mode
  SPI3_Write(address_high);            // addressing register
  SPI3_Write(address_low);             // addressing register
  data_r = SPI3_Read(dummy_data_r);    // read data from register

  CS = 1;
  return data_r;
}

/*
 * Transmit packet
 */
void start_transmit() {
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp | 0x01;                 // mask for start transmit
  write_ZIGBEE_short(TXNCON, temp);
}

/*
 * FIFO
 */
void read_RX_FIFO() {
  unsigned short int temp = 0;
  int i = 0;

  temp = read_ZIGBEE_short(BBREG1);      // disable receiving packets off air.
  temp = temp | 0x04;                    // mask for disable receiving packets
  write_ZIGBEE_short(BBREG1, temp);

  for(i=0; i<128; i++) {
    if(i <  (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
      data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);  // reading valid data from RX FIFO
    if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
      lost_data = read_ZIGBEE_long(address_RX_FIFO + i);        // reading invalid data from RX FIFO
  }

  DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];               // coping valid data
  DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];
  DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];
  LQI   = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];  // coping valid data
  RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];  // coping valid data

  temp = read_ZIGBEE_short(BBREG1);      // enable receiving packets off air.
  temp = temp & (!0x04);                 // mask for enable receiving
  write_ZIGBEE_short(BBREG1, temp);
}

void write_TX_normal_FIFO() {
  int i = 0;

  data_TX_normal_FIFO[0]  = HEADER_LENGHT;
  data_TX_normal_FIFO[1]  = HEADER_LENGHT + DATA_LENGHT;
  data_TX_normal_FIFO[2]  = 0x01;                        // control frame
  data_TX_normal_FIFO[3]  = 0x88;
  data_TX_normal_FIFO[4]  = SEQ_NUMBER;                  // sequence number
  data_TX_normal_FIFO[5]  = PAN_ID_2[1];                 // destinatoin pan
  data_TX_normal_FIFO[6]  = PAN_ID_2[0];
  data_TX_normal_FIFO[7]  = ADDRESS_short_2[0];          // destination address
  data_TX_normal_FIFO[8]  = ADDRESS_short_2[1];
  data_TX_normal_FIFO[9]  = PAN_ID_1[0];                 // source pan
  data_TX_normal_FIFO[10] = PAN_ID_1[1];
  data_TX_normal_FIFO[11] = ADDRESS_short_1[0];          // source address
  data_TX_normal_FIFO[12] = ADDRESS_short_1[1];
  data_TX_normal_FIFO[13] = DATA_TX[0];                  // data
  data_TX_normal_FIFO[14] = DATA_TX[1];
  data_TX_normal_FIFO[15] = DATA_TX[2];
  for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
    write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]); // write frame into normal FIFO
  }

  set_not_ACK();
  set_not_encrypt();
  start_transmit();
}