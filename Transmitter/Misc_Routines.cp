#line 1 "D:/git/sur/Transmitter/Misc_Routines.c"
#line 1 "d:/git/sur/transmitter/registers.h"
#line 1 "d:/git/sur/transmitter/readwrite_routines.h"
short int read_ZIGBEE_long(int address);
void write_ZIGBEE_long(int address, short int data_r);
short int read_ZIGBEE_short(short int address);
void write_ZIGBEE_short(short int address, short int data_r);
void read_RX_FIFO();
void start_transmit();
void write_TX_normal_FIFO();
#line 1 "d:/git/sur/transmitter/reset_routines.h"
void RF_reset();
void software_reset();
void MAC_reset();
void BB_reset();
void PWR_reset();
void pin_reset();
#line 5 "D:/git/sur/Transmitter/Misc_Routines.c"
extern sfr sbit WAKE_;
extern sfr sbit INT;
#line 11 "D:/git/sur/Transmitter/Misc_Routines.c"
void enable_interrupt() {
 write_ZIGBEE_short( 0x32 , 0x00);
}
#line 18 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_channel(short int channel_number) {
 if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
 switch(channel_number) {
 case 11:
 write_ZIGBEE_long( 0x200 , 0x02);
 break;
 case 12:
 write_ZIGBEE_long( 0x200 , 0x12);
 break;
 case 13:
 write_ZIGBEE_long( 0x200 , 0x22);
 break;
 case 14:
 write_ZIGBEE_long( 0x200 , 0x32);
 break;
 case 15:
 write_ZIGBEE_long( 0x200 , 0x42);
 break;
 case 16:
 write_ZIGBEE_long( 0x200 , 0x52);
 break;
 case 17:
 write_ZIGBEE_long( 0x200 , 0x62);
 break;
 case 18:
 write_ZIGBEE_long( 0x200 , 0x72);
 break;
 case 19:
 write_ZIGBEE_long( 0x200 , 0x82);
 break;
 case 20:
 write_ZIGBEE_long( 0x200 , 0x92);
 break;
 case 21:
 write_ZIGBEE_long( 0x200 , 0xA2);
 break;
 case 22:
 write_ZIGBEE_long( 0x200 , 0xB2);
 break;
 case 23:
 write_ZIGBEE_long( 0x200 , 0xC2);
 break;
 case 24:
 write_ZIGBEE_long( 0x200 , 0xD2);
 break;
 case 25:
 write_ZIGBEE_long( 0x200 , 0xE2);
 break;
 case 26:
 write_ZIGBEE_long( 0x200 , 0xF2);
 break;
 }
 RF_reset();
}
#line 76 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_CCA_mode(short int CCA_mode) {
 short int temp = 0;
 switch(CCA_mode) {
 case 1: {
 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0x80;
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x3A , temp);
 write_ZIGBEE_short( 0x3F , 0x60);
 }
 break;

 case 2: {
 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0x40;
 temp = temp & 0x7F;
 write_ZIGBEE_short( 0x3A , temp);

 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0x38;
 temp = temp & 0xFB;
 write_ZIGBEE_short( 0x3A , temp);
 }
 break;

 case 3: {
 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0xC0;
 write_ZIGBEE_short( 0x3A , temp);

 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0x38;
 temp = temp & 0xFB;
 write_ZIGBEE_short( 0x3A , temp);

 write_ZIGBEE_short( 0x3F , 0x60);
 }
 break;
 }
 }
#line 120 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_RSSI_mode(short int RSSI_mode) {
 short int temp = 0;

 switch(RSSI_mode) {
 case 1: {
 temp = read_ZIGBEE_short( 0x3E );
 temp = temp | 0x80;
 write_ZIGBEE_short( 0x3E , temp);
 }
 break;

 case 2:
 write_ZIGBEE_short( 0x3E , 0x40);
 break;
 }
}
#line 140 "D:/git/sur/Transmitter/Misc_Routines.c"
void nonbeacon_PAN_coordinator_device() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x00 );
 temp = temp | 0x08;
 write_ZIGBEE_short( 0x00 , temp);

 temp = read_ZIGBEE_short( 0x11 );
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x11 , temp);

 write_ZIGBEE_short( 0x10 , 0xFF);
}

void nonbeacon_coordinator_device() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x00 );
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x00 , temp);

 temp = read_ZIGBEE_short( 0x11 );
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x11 , temp);

 write_ZIGBEE_short( 0x10 , 0xFF);
}

void nonbeacon_device() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & 0xF3;
 write_ZIGBEE_short( 0x00 , temp);

 temp = read_ZIGBEE_short( 0x11 );
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x11 , temp);
}
#line 183 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_ACK() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x1B , temp);
}

void set_not_ACK() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp & (!0x04);
 write_ZIGBEE_short( 0x1B , temp);
}
#line 202 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_encrypt() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp | 0x02;
 write_ZIGBEE_short( 0x1B , temp);
}

void set_not_encrypt(void){
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp & (!0x02);
 write_ZIGBEE_short( 0x1B , temp);
}
#line 221 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_IFS_recomended() {
 short int temp = 0;

 write_ZIGBEE_short( 0x00 , 0x93);

 temp = read_ZIGBEE_short( 0x21 );
 temp = temp | 0x7C;
 write_ZIGBEE_short( 0x21 , temp);

 temp = read_ZIGBEE_short( 0x2E );
 temp = temp | 0x90;
 write_ZIGBEE_short( 0x2E , temp);

 temp = read_ZIGBEE_short( 0x27 );
 temp = temp | 0x31;
 write_ZIGBEE_short( 0x27 , temp);
}

void set_IFS_default() {
 short int temp = 0;

 write_ZIGBEE_short( 0x00 , 0x75);

 temp = read_ZIGBEE_short( 0x21 );
 temp = temp | 0x84;
 write_ZIGBEE_short( 0x21 , temp);

 temp = read_ZIGBEE_short( 0x2E );
 temp = temp | 0x50;
 write_ZIGBEE_short( 0x2E , temp);

 temp = read_ZIGBEE_short( 0x27 );
 temp = temp | 0x41;
 write_ZIGBEE_short( 0x27 , temp);
}
#line 260 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_reception_mode(short int r_mode) {
 short int temp = 0;

 switch(r_mode) {
 case 1: {
 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & (!0x03);
 write_ZIGBEE_short( 0x00 , temp);
 }
 break;

 case 2: {
 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & (!0x01);
 temp = temp | 0x02;
 write_ZIGBEE_short( 0x00 , temp);
 }
 break;

 case 3: {
 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & (!0x02);
 temp = temp | 0x01;
 write_ZIGBEE_short( 0x00 , temp);
 }
 break;
 }
}
#line 292 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_frame_format_filter(short int fff_mode) {
 short int temp = 0;

 switch(fff_mode) {
 case 1: {
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp & (!0x0E);
 write_ZIGBEE_short( 0x0D , temp);
 }
 break;

 case 2: {
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp & (!0x06);
 temp = temp | 0x08;
 write_ZIGBEE_short( 0x0D , temp);
 }
 break;

 case 3: {
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp & (!0x0A);
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x0D , temp);
 }
 break;

 case 4: {
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp & (!0x0C);
 temp = temp | 0x02;
 write_ZIGBEE_short( 0x0D , temp);
 }
 break;
 }
}
#line 332 "D:/git/sur/Transmitter/Misc_Routines.c"
void flush_RX_FIFO_pointer() {
 short int temp;

 temp = read_ZIGBEE_short( 0x0D );
 temp = temp | 0x01;
 write_ZIGBEE_short( 0x0D , temp);
}
#line 343 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_short_address(short int * address) {
 write_ZIGBEE_short( 0x03 , address[0]);
 write_ZIGBEE_short( 0x04 , address[1]);
}

void set_long_address(short int * address) {
 short int i = 0;

 for(i = 0; i < 8; i++) {
 write_ZIGBEE_short( 0x05  + i, address[i]);
 }
}

void set_PAN_ID(short int * address) {
 write_ZIGBEE_short( 0x01 , address[0]);
 write_ZIGBEE_short( 0x02 , address[1]);
}
#line 364 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_wake_from_pin() {
 short int temp = 0;

 WAKE_ = 0;
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp | 0x60;
 write_ZIGBEE_short( 0x0D , temp);

 temp = read_ZIGBEE_short( 0x22 );
 temp = temp | 0x80;
 write_ZIGBEE_short( 0x22 , temp);
}

void pin_wake() {
 WAKE_ = 1;
 Delay_ms(5);
}
#line 385 "D:/git/sur/Transmitter/Misc_Routines.c"
void enable_PLL() {
 write_ZIGBEE_long( 0x202 , 0x80);
}

void disable_PLL() {
 write_ZIGBEE_long( 0x202 , 0x00);
}
#line 396 "D:/git/sur/Transmitter/Misc_Routines.c"
void set_TX_power(unsigned short int power) {
 if((power < 0) || (power > 31))
 power = 31;
 power = 31 - power;
 power = ((power & 0b00011111) << 3) & 0b11111000;
 write_ZIGBEE_long( 0x203 , power);
}
#line 407 "D:/git/sur/Transmitter/Misc_Routines.c"
void init_ZIGBEE_basic() {
 write_ZIGBEE_short( 0x18 , 0x98);
 write_ZIGBEE_short( 0x2E , 0x95);
 write_ZIGBEE_long( 0x201 , 0x01);
 enable_PLL();
 write_ZIGBEE_long( 0x206 , 0x90);
 write_ZIGBEE_long( 0x207 , 0x80);
 write_ZIGBEE_long( 0x208 , 0x10);
 write_ZIGBEE_long( 0x220 , 0x21);
}

void init_ZIGBEE_nonbeacon() {
 init_ZIGBEE_basic();
 set_CCA_mode(1);
 set_RSSI_mode(2);
 enable_interrupt();
 set_channel(11);
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
