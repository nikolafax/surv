#line 1 "C:/SRV/Projekat/surv/Transmitter/Init_Routines.c"
#line 1 "c:/srv/projekat/surv/transmitter/registers.h"
#line 1 "c:/srv/projekat/surv/transmitter/readwrite_routines.h"
short int read_ZIGBEE_long(int address);
void write_ZIGBEE_long(int address, short int data_r);
short int read_ZIGBEE_short(short int address);
void write_ZIGBEE_short(short int address, short int data_r);
void read_RX_FIFO();
void start_transmit();
void write_TX_normal_FIFO();
#line 1 "c:/srv/projekat/surv/transmitter/reset_routines.h"
void RF_reset();
void software_reset();
void MAC_reset();
void BB_reset();
void PWR_reset();
void pin_reset();
#line 1 "c:/srv/projekat/surv/transmitter/misc_routines.h"
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
#line 6 "C:/SRV/Projekat/surv/Transmitter/Init_Routines.c"
extern sfr sbit TFT_BLED;
extern short int ADDRESS_short_1[], ADDRESS_short_2[], ADDRESS_long_1[], ADDRESS_long_2[], PAN_ID_1[], PAN_ID_2[];
extern short int LQI, RSSI2, SEQ_NUMBER, lost_data;
extern int address_RX_FIFO, address_TX_normal_FIFO;
extern short int DATA_TX[];

void Initialize() {
 short int i = 0;

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


 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_13);
 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_10);
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_2);


 GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_0);

 DATA_TX[0] = 0;

 Delay_ms(5);


 SPI3_Init_Advanced(_SPI_FPCLK_DIV4, _SPI_MASTER | _SPI_8_BIT |
 _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION |
 _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
 &_GPIO_MODULE_SPI3_PC10_11_12);
 TFT_BLED = 1;

 TFT_Init(320, 240);
 TFT_Fill_Screen(CL_WHITE);

 pin_reset();
 software_reset();
 RF_reset();
 set_WAKE_from_pin();

 set_long_address(ADDRESS_long_1);
 set_short_address(ADDRESS_short_1);
 set_PAN_ID(PAN_ID_1);

 init_ZIGBEE_nonbeacon();
 nonbeacon_PAN_coordinator_device();
 set_TX_power(31);
 set_frame_format_filter(1);
 set_reception_mode(1);

 pin_wake();
}
