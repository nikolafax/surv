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
// Recieve data from boards
extern short int DATA_RX[];
// Send data to
extern short int DATA_TX[];
short int temp1;
char txt[4];
unsigned int cnt = 0;

char writebuff[64];
char readbuff[64];
char kk;
void usbRecive();
void beeSend();
void usbSend();
void draw_frame();

void draw_frame() {
        TFT_Init_ILI9341_8bit(320, 240);
        TFT_Fill_Screen(CL_WHITE);

        TFT_Write_Text(">>> COMMUNICATOR <<<", 80, 20);
        TFT_Write_Text("Byte 1 :", 140, 80);
        TFT_Write_Text("Byte 2 :", 140, 120);
        TFT_Write_Text("Byte 3 :", 140, 160);
        // Display stuff
        TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
        // Fill rect
        TFT_Set_Brush(1, CL_WHITE, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
        // Rect border delete
        TFT_Set_Pen(CL_WHITE, 0);
}

void display_on_screen() {
        ByteToStr(DATA_TX[0], &txt);      // Convert byte to string
        TFT_Write_Text(txt, 215, 80);    // Display string on TFT

        ByteToStr(DATA_TX[1], &txt);
        TFT_Write_Text(txt, 215, 120);

        ByteToStr(DATA_TX[2], &txt);
        TFT_Write_Text(txt, 215, 160);

        delay_ms(200);

        // Clear screen with white rectangle
        TFT_Rectangle(215, 40, 255, 180);

}

void usbCommunication() {
        USB_Polling_Proc();

        if (HID_Read() != 0) {                                    //usb data recived
            if (readbuff[2] == 0) { //Read request from server - usb polling protocol
                    usbSend();
            } else {                                      //Data recived form server
                    beeSend();
            }
        }
}

void usbSend() {
    // Send to server
    writebuff[0] = DATA_RX[0];
    writebuff[1] = DATA_RX[1];
    writebuff[2] = DATA_RX[2];

    HID_Write(&writebuff, 64);
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
           display_on_screen();
        }
}

void main() {
        Initialize();
        draw_frame();

        HID_Enable(&readbuff, &writebuff);
        GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
        Delay_ms(100);
        do {
           beeRecive();
           Delay_ms(100);
           usbCommunication();
        } while (1);

}