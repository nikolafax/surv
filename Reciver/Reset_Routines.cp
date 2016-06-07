#line 1 "D:/git/sur/Reciver/Reset_Routines.c"
#line 1 "d:/git/sur/reciver/registers.h"
#line 1 "d:/git/sur/reciver/readwrite_routines.h"
short int read_ZIGBEE_long(int address);
void write_ZIGBEE_long(int address, short int data_r);
short int read_ZIGBEE_short(short int address);
void write_ZIGBEE_short(short int address, short int data_r);
void read_RX_FIFO();
void start_transmit();
void write_TX_normal_FIFO();
#line 4 "D:/git/sur/Reciver/Reset_Routines.c"
extern sfr sbit RST;
#line 12 "D:/git/sur/Reciver/Reset_Routines.c"
void pin_reset() {
 RST = 0;
 Delay_ms(5);
 RST = 1;
 Delay_ms(5);
}

void PWR_reset() {
 write_ZIGBEE_short( 0x2A , 0x04);
}

void BB_reset() {
 write_ZIGBEE_short( 0x2A , 0x02);
}

void MAC_reset() {
 write_ZIGBEE_short( 0x2A , 0x01);
}

void software_reset() {
 write_ZIGBEE_short( 0x2A , 0x07);
}

void RF_reset() {
 short int temp = 0;
 temp = read_ZIGBEE_short( 0x36 );
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x36 , temp);
 temp = temp & (!0x04);
 write_ZIGBEE_short( 0x36 , temp);
 Delay_ms(1);
}
