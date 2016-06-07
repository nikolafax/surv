#line 1 "C:/SRV/Projekat/surv/Komunikator/ReadWrite_Routines.c"
#line 1 "c:/srv/projekat/surv/komunikator/registers.h"
#line 1 "c:/srv/projekat/surv/komunikator/misc_routines.h"
void init_ZIGBEE_nonbeacon();
void init_ZIGBEE_basic();
void set_TX_power(unsigned short int power);
void disable_PLL();
void enable_PLL();
void pin_wake();
void set_wake_from_pin();
void set_PAN_ID(short int * address);
void set_PAN_ID(short int * address);
void set_long_address(short int * address);
void set_short_address(short int * address);
void flush_RX_FIFO_pointer();
void set_frame_format_filter(short int fff_mode);
void set_reception_mode(short int r_mode);
void set_IFS_default();
void set_IFS_recomended();
void set_not_encrypt();
void set_encrypt();
void set_not_ACK();
void set_ACK();
void nonbeacon_device();
void nonbeacon_coordinator_device();
void nonbeacon_PAN_coordinator_device();
void set_RSSI_mode(short int RSSI_mode);
void set_CCA_mode(short int CCA_mode);
void set_channel(short int channel_number);
void enable_interrupt();
char Debounce_INT();
#line 4 "C:/SRV/Projekat/surv/Komunikator/ReadWrite_Routines.c"
extern sfr sbit CS;


const unsigned short int DATA_LENGHT = 3;
const unsigned short int HEADER_LENGHT = 11;

int address_RX_FIFO, address_TX_normal_FIFO;
short int data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2 + 1 + 1], lost_data;

short int ADDRESS_short_1[2], ADDRESS_long_1[8];
short int ADDRESS_short_2[2], ADDRESS_long_2[8];
short int PAN_ID_1[2];
short int PAN_ID_2[2];
short int DATA_RX[DATA_LENGHT], DATA_TX[DATA_LENGHT], data_TX_normal_FIFO[DATA_LENGHT + HEADER_LENGHT + 2];
short int LQI, RSSI2, SEQ_NUMBER;
#line 25 "C:/SRV/Projekat/surv/Komunikator/ReadWrite_Routines.c"
void write_ZIGBEE_short(short int address, short int data_r) {
 CS = 0;

 address = ((address << 1) & 0b01111111) | 0x01;
 SPI3_Write(address);
 SPI3_Write(data_r);

 CS = 1;
}


short int read_ZIGBEE_short(short int address) {
 short int data_r = 0, dummy_data_r = 0;

 CS = 0;

 address = (address << 1) & 0b01111110;
 SPI3_Write(address);
 data_r = SPI3_Read(dummy_data_r);
 CS = 1;
 return data_r;
}
#line 52 "C:/SRV/Projekat/surv/Komunikator/ReadWrite_Routines.c"
void write_ZIGBEE_long(int address, short int data_r) {
 short int address_high = 0, address_low = 0;

 CS = 0;

 address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;
 address_low = (((short int)(address << 5)) & 0b11100000) | 0x10;
 SPI3_Write(address_high);
 SPI3_Write(address_low);
 SPI3_Write(data_r);

 CS = 1;
}


short int read_ZIGBEE_long(int address) {
 short int data_r = 0, dummy_data_r = 0;
 short int address_high = 0, address_low = 0;

 CS = 0;

 address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;
 address_low = ((short int)(address << 5) & 0b11100000);
 SPI3_Write(address_high);
 SPI3_Write(address_low);
 data_r = SPI3_Read(dummy_data_r);

 CS = 1;
 return data_r;
}
#line 86 "C:/SRV/Projekat/surv/Komunikator/ReadWrite_Routines.c"
void start_transmit() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp | 0x01;
 write_ZIGBEE_short( 0x1B , temp);
}
#line 97 "C:/SRV/Projekat/surv/Komunikator/ReadWrite_Routines.c"
void read_RX_FIFO() {
 unsigned short int temp = 0;
 int i = 0;

 temp = read_ZIGBEE_short( 0x39 );
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x39 , temp);

 for(i=0; i<128; i++) {
 if(i < (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
 data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);
 if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
 lost_data = read_ZIGBEE_long(address_RX_FIFO + i);
 }

 DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];
 DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];
 DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];
 LQI = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];
 RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];

 temp = read_ZIGBEE_short( 0x39 );
 temp = temp & (!0x04);
 write_ZIGBEE_short( 0x39 , temp);
}

void write_TX_normal_FIFO() {
 int i = 0;

 data_TX_normal_FIFO[0] = HEADER_LENGHT;
 data_TX_normal_FIFO[1] = HEADER_LENGHT + DATA_LENGHT;
 data_TX_normal_FIFO[2] = 0x01;
 data_TX_normal_FIFO[3] = 0x88;
 data_TX_normal_FIFO[4] = SEQ_NUMBER;
 data_TX_normal_FIFO[5] = PAN_ID_2[1];
 data_TX_normal_FIFO[6] = PAN_ID_2[0];
 data_TX_normal_FIFO[7] = ADDRESS_short_2[0];
 data_TX_normal_FIFO[8] = ADDRESS_short_2[1];
 data_TX_normal_FIFO[9] = PAN_ID_1[0];
 data_TX_normal_FIFO[10] = PAN_ID_1[1];
 data_TX_normal_FIFO[11] = ADDRESS_short_1[0];
 data_TX_normal_FIFO[12] = ADDRESS_short_1[1];
 data_TX_normal_FIFO[13] = DATA_TX[0];
 data_TX_normal_FIFO[14] = DATA_TX[1];
 data_TX_normal_FIFO[15] = DATA_TX[2];
 for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
 write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]);
 }

 set_not_ACK();
 set_not_encrypt();
 start_transmit();
}
