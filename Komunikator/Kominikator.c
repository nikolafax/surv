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
short int temp1;
char txt[1];
char cnt;
//usb
char writebuff[64];
char readbuff[64];
char kk;

void usbSend() {
        USB_Polling_Proc();

        for (cnt = 0; cnt < 64; cnt++) {
                writebuff[cnt] = 0;
        }
        writebuff[0] = DATA_RX[0];
        writebuff[1] = DATA_RX[1];
        writebuff[2] = DATA_RX[2];

        HID_Write(&writebuff, 64);

}

void usbRecive() {

}

void beeSend() {

}

void beeRecive() {
        if (Debounce_INT() == 0) {             // Debounce line INT
                temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
                read_RX_FIFO();                     // Read receive data

                TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
                ByteToStr(DATA_RX[0], &txt);         // Convert third byte to string
                TFT_Write_Text(txt, 195, 80);       // Display string on TFT

                ByteToStr(DATA_RX[1], &txt);
                TFT_Write_Text(txt, 195, 90);

                ByteToStr(DATA_RX[2], &txt);
                TFT_Write_Text(txt, 195, 100);

                delay_ms(500);
                TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
                ByteToStr(DATA_RX[0], &txt);
                TFT_Write_Text(txt, 195, 80);       // Delete string from TFT

                ByteToStr(DATA_RX[1], &txt);
                TFT_Write_Text(txt, 195, 90);

                ByteToStr(DATA_RX[2], &txt);
                TFT_Write_Text(txt, 195, 100);

                GPIOD_ODR = DATA_RX[0];
        }
}
void DrawFrame() {
        TFT_Init_ILI9341_8bit(320, 240);
        TFT_Fill_Screen(CL_WHITE);
}
void main() {

        HID_Enable(&readbuff, &writebuff);

        GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0); // Set PA0 as digital input
        GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_1); // Set PA0 as digital input

        GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL);
        GPIOC_ODR = 0;

        Delay_ms(100);

        GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);

        Initialize();
        DrawFrame();

        do {
                beeRecive();
                kk = HID_Read();
                if (kk != 0) {
                        usbSend();
                }

        } while (1);

}