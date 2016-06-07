#include "resources.h"
#include "registers.h"
#include "ReadWrite_Routines.h"
#include "Reset_Routines.h"
#include "Misc_Routines.h"
#include "Init_Routines.h"

// BEE Click Board connections
sbit CS at GPIOD_ODR.B13;// CS pin
sbit RST at GPIOC_ODR.B2;// RST pin
sbit INT at GPIOD_ODR.B10;// INT pin
sbit WAKE_ at GPIOA_ODR.B4;// WAKE pin
// Transmitting data
extern short int DATA_TX[];
// Recieving data
extern short int DATA_RX[];

char txt[4];
short int button1;
short int button2;
short int temp1;
//  2 bits sID  , 1b B1, 1b B2, 4bits for analog by this order in recivedByteOne byte
unsigned short recivedByteOne = 0;
// 8 bits for analog
unsigned short recivedByteTwo = 0;
// Board ID (whole byte)
unsigned short deviceIdByte = 0;
// ANALOG
unsigned short adc_h;
unsigned short adc_l;
int adc_result = 0;
int life_notifyer_counter = 0;

void brodcast_id_request();

void draw_frame() {
	TFT_Init_ILI9341_8bit(320, 240);
	TFT_Fill_Screen(CL_WHITE);
	TFT_Write_Text("BOARD ID :", 140, 40);    // Display string on TFT
	TFT_Write_Text("Button 1 :", 140, 80);
	TFT_Write_Text("Button 2 :", 140, 120);
	TFT_Write_Text("ANALOG 1 :", 140, 160);
}

void parse_adc_values() {
	adc_result = adc_h * 265;
	adc_result = adc_result + adc_l;

}

void display_on_screen() {
	// Display stuff
	TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);

	ByteToStr(deviceIdByte, &txt);
	TFT_Write_Text(txt, 215, 40);

	ByteToStr(button1, &txt);      // Convert byte to string
	TFT_Write_Text(txt, 215, 80);    // Display string on TFT

	ByteToStr(button2, &txt);
	TFT_Write_Text(txt, 215, 120);

	parse_adc_values();
	IntToStr(adc_result, &txt);
	TFT_Write_Text(txt, 215, 160);
}

void clearScreen() {
	// Clear screen
	TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);

	ByteToStr(deviceIdByte, &txt);
	TFT_Write_Text(txt, 215, 40);

	ByteToStr(button1, &txt);
	TFT_Write_Text(txt, 215, 80);

	ByteToStr(button2, &txt);
	TFT_Write_Text(txt, 215, 120);

	ByteToStr(adc_result, &txt);
	TFT_Write_Text(txt, 215, 160);
}

void listen_for_id() {
	brodcast_id_request();
	delay_ms(100);
	// ID is not,jet, set
	if (Debounce_INT() == 0) {
		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
		read_RX_FIFO();                     // Read receive data
		// Check if message is for me
		if (DATA_RX[0] == 112) { //0xff is controler to senzor message id, which is send only for senzort to get id
			deviceIdByte = DATA_RX[2];
		}
	}
}

void brodcast_id_request() {

	// PROTOCOL BYTES
	DATA_TX[0] = 0x40;
	DATA_TX[1] = 0;
	DATA_TX[2] = deviceIdByte;

	if (life_notifyer_counter > 50) {
		life_notifyer_counter = 0;
	}

	// SENDING
	write_TX_normal_FIFO();          // Transmiting
}

void processRecivedData() {
	button1 = DATA_RX[0] & 0x20;
	button2 = DATA_RX[0] & 0x19;
	adc_h = DATA_RX[0] % 0x0f;
	adc_l = DATA_RX[1];
}

void beeReciveData() {
	if (Debounce_INT() == 0) {
		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
		read_RX_FIFO();
		if (DATA_RX[2] == deviceIdByte) {
			clearScreen();
			processRecivedData();
			display_on_screen();
		}
		DATA_RX[2] = 0;
	}

}

void main() {
	Initialize();                      // Initialize MCU and Bee click board
	draw_frame();

	GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
	Delay_ms(100);
	// Listen for my ID
	while (deviceIdByte == 0) {
		listen_for_id();
		// Pause between sendings
		Delay_ms(50);
	}
	while (1) {
		beeReciveData();
		// Pause between sendings
		Delay_ms(10);
		life_notifyer_counter++;
		if (life_notifyer_counter == 50) {
			brodcast_id_request();
		}
	}
}
