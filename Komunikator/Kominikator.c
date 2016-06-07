#include "resources.h"
#include "registers.h"
#include "ReadWrite_Routines.h"
#include "Reset_Routines.h"
#include "Misc_Routines.h"
#include "Init_Routines.h"

//bee reciver
sbit CS at GPIOD_ODR.B13;// CS pin
sbit RST at GPIOC_ODR.B2;// RST pin
sbit INT at GPIOD_ODR.B10;// INT pin
sbit WAKE_ at GPIOA_ODR.B4;

extern short int DATA_RX[];
extern short int DATA_TX[];
short int BEE_RECIVED_DATA[64];
short int USB_RECIVED_DATA[64];
short int temp1;
char txt[8];
char
char cnt;
char messageDestination;

char writebuff[64];
char readbuff[64];
char kk;
void usbRecive();
void beeSend();
void usbSend();
void DrawFrame();
void clearDataFromScreen();

void usbCommunication() {
	USB_Polling_Proc();
	DrawFrame();
	if (HID_Read() != 0) {                                    //usb data recived
		if (readbuff[2] == 0) { //Read request from server - usb polling protocol
			usbSend();
		} else {                                      //Data recived form server
			beeSend();
		}
	}
}

void usbSend() {
	writebuff[0] = BEE_RECIVED_DATA[0];
	writebuff[1] = BEE_RECIVED_DATA[1];
	writebuff[2] = BEE_RECIVED_DATA[2];
	DrawFrame();
	HID_Write(&writebuff, 64);
	Delay_ms(1000);
	clearDataFromScreen();
	BEE_RECIVED_DATA[0] = 0;
	BEE_RECIVED_DATA[1] = 0;
	BEE_RECIVED_DATA[2] = 0;
}

void beeSend() {

	DATA_TX[0] = readbuff[0];
	DATA_TX[1] = readbuff[1];
	DATA_TX[2] = readbuff[2];

	write_TX_normal_FIFO();

	readbuff[0] = 0;
	readbuff[1] = 0;
	readbuff[2] = 0;

}

void beeRecive() {
	if (Debounce_INT() == 0) {             // Debounce line INT
		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
		read_RX_FIFO();                     // Read receive data

		messageDestination = BEE_RECIVED_DATA[0];
		messageDestination &= 0xC0;
		if (messageDestination == 0 || messageDestination == 192) {
			BEE_RECIVED_DATA[0] = DATA_RX[0];
			BEE_RECIVED_DATA[1] = DATA_RX[1];
			BEE_RECIVED_DATA[2] = DATA_RX[2];
//			DrawFrame();
		}
	}
}
void DrawFrame() {
	TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
	ByteToStr(writebuff[0], &txt);         // Convert third byte to string
	TFT_Write_Text(txt, 195, 80);       // Display string on TFT

	ByteToStr(writebuff[1], &txt);
	TFT_Write_Text(txt, 195, 90);

	ByteToStr(writebuff[2], &txt);
	TFT_Write_Text(txt, 195, 100);

	ByteToStr(writebuff[2], &txt);
	TFT_Write_Text('a', 195, 120);

}

void clearDataFromScreen() {
	TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
	ByteToStr(writebuff[0], &txt);
	TFT_Write_Text(txt, 195, 80);       // Delete string from TFT

	ByteToStr(writebuff[1], &txt);
	TFT_Write_Text(txt, 195, 90);

	ByteToStr(writebuff[2], &txt);
	TFT_Write_Text(txt, 195, 100);

	ByteToStr(writebuff[2], &txt);
	TFT_Write_Text('a', 195, 120);
}

void main() {

	TFT_Init_ILI9341_8bit(320, 240);
	TFT_Fill_Screen(CL_WHITE);

	BEE_RECIVED_DATA[0] = 0;
	BEE_RECIVED_DATA[1] = 0;
	BEE_RECIVED_DATA[2] = 0;

	USB_RECIVED_DATA[0] = 0;
	USB_RECIVED_DATA[1] = 0;
	USB_RECIVED_DATA[2] = 0;

	HID_Enable(&readbuff, &writebuff);

//	GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0); // Set PA0 as digital input
//	GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_1); // Set PA0 as digital input

//	GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL);
//	GPIOC_ODR = 0;

	Delay_ms(100);

//	GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);

	Initialize();
//	DrawFrame();


	TFT_Write_Text("xxx", 195, 80);
        Delay_ms(2000);
	do {
		beeRecive();
		usbCommunication();
	} while (1);

}